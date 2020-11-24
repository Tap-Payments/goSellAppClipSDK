//
//  ErrorReporterImpl.swift
//  TapErrorReporting
//
//  Copyright © 2019 Tap Payments. All rights reserved.
//

import class	TapAdditionsKitV2.SeparateWindowRootViewController
import struct	TapAdditionsKitV2.TypeAlias
import TapAlertViewControllerV2
import class	TapApplicationV2.TapApplicationPlistInfo
import class	TapBundleLocalization.LocalizationProvider
import TapNetworkManagerV2
import class	UIKit.UIAlertController.UIAlertAction
import class	UIKit.UIAlertController.UIAlertController
import class	UIKit.UIDevice.UIDevice

internal final class ErrorReporterImpl: ErrorReporting {
	
	// MARK: - Internal -
	// MARK: Properties
	
	internal var language: String {
		
		get {
			
			return self.localizationProvider.selectedLanguage
		}
		set {
			
			self.localizationProvider.selectedLanguage = newValue
		}
	}
	
	internal var canReport: Bool {
		
		return !UserDefaults.standard.bool(forKey: Constants.errorReportingForbiddenKey)
	}
	
	// MARK: Methods
	
	internal func report(_ error: Encodable, in product: String, productVersion: String, alertOrientationHandler: OrientationHandler) {
		
		DispatchQueue.main.async {
			
			self.askUserPermissionToReport(alertOrientationHandler) { [weak self] (granted) in
				
				guard granted else { return }
				
				self?.reportError(error, in: product, version: productVersion, orientationHandler: alertOrientationHandler)
			}
		}
	}
	
	// MARK: - Private -
	
	private struct Constants {
		
		fileprivate static let canAutoSendReportKey			= Constants.userDefaultsPrefix + ".can_send_report_automatically"
		fileprivate static let errorReportingForbiddenKey	= Constants.userDefaultsPrefix + ".error_reporting_forbidden"
		
		fileprivate static let reportErrorAPIPath			= "reportError"
		fileprivate static let region						= "europe-west1"
		fileprivate static let projectID					= "tap-error-reporting"
		fileprivate static let baseURL						= URL(string: "https://\(Constants.region)-\(Constants.projectID).cloudfunctions.net/")!

		fileprivate static let productKey			= "product"
		fileprivate static let productVersionKey	= "version"
		fileprivate static let osKey				= "os"
		fileprivate static let osVersionKey			= "os_version"
		fileprivate static let bundleIDKey			= "bundle_id"
		fileprivate static let timeKey				= "time"
		fileprivate static let dataKey				= "data"
		
		private static let userDefaultsPrefix = "company.tap.error_reporting"
		
		@available(*, unavailable) private init() { fatalError("This struct cannot be instantiated.") }
	}
	
	// MARK: Properties
	
	private lazy var localizationProvider	= LocalizationProvider(bundle: .errorReportingResources)
	private lazy var networkManager: TapNetworkManager			= {
		
		let manager = TapNetworkManager(baseURL: Constants.baseURL)
		manager.isRequestLoggingEnabled = true
		
		return manager
	}()
	
	private lazy var dateFormatter = DateFormatter()
	
	private lazy var applicationMetadata: [String: Any] = [
	
		Constants.osKey:		UIDevice.current.systemName,
		Constants.osVersionKey:	UIDevice.current.systemVersion,
		Constants.bundleIDKey:	TapApplicationPlistInfo.shared.bundleIdentifier ?? "nil",
		Constants.timeKey:		self.currentDateString
	]
	
	private var currentDateString: String {
		
		return self.dateFormatter.string(from: Date())
	}
	
	// MARK: Methods
	
	private func askUserPermissionToReport(_ alertOrientationHandler: OrientationHandler, _ grantedClosure: @escaping TypeAlias.BooleanClosure) {
		
		if UserDefaults.standard.bool(forKey: Constants.errorReportingForbiddenKey) {
			
			grantedClosure(false)
			return
		}
		
		if UserDefaults.standard.bool(forKey: Constants.canAutoSendReportKey) {
			
			grantedClosure(true)
			return
		}
		
		let title = self.localizationProvider.localizedString(for: .alert_report_error_title)
		let message = self.localizationProvider.localizedString(for: .alert_report_error_message)
		let dontAskAgainText = self.localizationProvider.localizedString(for: .alert_report_error_dont_ask_again)
		
		var dontAskAgainValue = false
		
		let dontAskAgainView = DontAskMeAgainView(text: dontAskAgainText, defaultValue: false) { dontAskAgainValue = $0 }
		
		let alert = TapAlertViewController.with(title: title, message: message)
		alert.customView = dontAskAgainView
		
		let localGranted: TypeAlias.BooleanClosure = { (granted) in
			
			if dontAskAgainValue {
				
				if granted {
					
					UserDefaults.standard.setValue(true, forKey: Constants.canAutoSendReportKey)
				}
				else {
					
					UserDefaults.standard.setValue(true, forKey: Constants.errorReportingForbiddenKey)
				}
				
				UserDefaults.standard.synchronize()
			}
			
			grantedClosure(granted)
		}
		
		let dontAllowAction = TapAlertAction(style: .default, title: self.localizationProvider.localizedString(for: .alert_report_error_btn_dont_allow)) { [weak alert] (action) in
			
			if let nonnullAlert = alert {
				
				nonnullAlert.hide {
					
					localGranted(false)
				}
			}
			else {
				
				localGranted(false)
			}
		}
		
		let allowAction = TapAlertAction(style: .bold, title: self.localizationProvider.localizedString(for: .alert_report_error_btn_allow)) { [weak alert] (action) in
			
			if let nonnullAlert = alert {
				
				nonnullAlert.hide {
					
					localGranted(true)
				}
			}
			else {
				
				localGranted(true)
			}
		}
		
		let doubleAction = TapAlertDoubleAction(leadingAction: dontAllowAction, trailingAction: allowAction)
		alert.add(action: doubleAction)
		
		alert.show(orientationHandler: alertOrientationHandler)
	}
	
	private func reportError(_ error: Encodable, in product: String, version: String, orientationHandler: OrientationHandler) {
		
		var data = self.applicationMetadata
		
		data[Constants.timeKey]				= self.currentDateString
		data[Constants.productKey]			= product
		data[Constants.productVersionKey]	= version
		
		let errorDictionary = (try? error.tap_asDictionary()) ?? [:]
		data[Constants.dataKey] = errorDictionary
		
		let body = TapBodyModel(body: data)
		let operation = TapNetworkRequestOperation(path: Constants.reportErrorAPIPath, method: .POST, headers: nil, urlModel: nil, bodyModel: body, responseType: .json)
		self.networkManager.performRequest(operation) { [weak self] (dataTask, response, error) in
			
			if let nonnullError = error {
				
				print("Error: \(nonnullError)")
			}
			else {
				
				self?.showSuccessAlert(orientationHandler)
			}
		}
	}
	
	private func showSuccessAlert(_ handler: OrientationHandler) {
		
		let title = self.localizationProvider.localizedString(for: .alert_report_error_success_title)
		let message = self.localizationProvider.localizedString(for: .alert_report_error_success_message)
		
		let alert = TapAlertViewController.with(title: title, message: message)
		
		let dismissTitle = self.localizationProvider.localizedString(for: .alert_report_error_success_btn_dismiss)
		let dismissAction = TapAlertAction(style: .default, title: dismissTitle) { [weak alert] (action) in
			
			if let nonnullAlert = alert {
				
				nonnullAlert.hide()
			}
		}
		
		alert.add(action: dismissAction)
		
		alert.show(orientationHandler: handler)
	}
}
