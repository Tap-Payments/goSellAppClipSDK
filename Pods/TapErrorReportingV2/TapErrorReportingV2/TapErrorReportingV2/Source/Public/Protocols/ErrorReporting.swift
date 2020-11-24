//
//  ErrorReporting.swift
//  TapErrorReporting
//
//  Copyright © 2019 Tap Payments. All rights reserved.
//

import protocol	TapAdditionsKitV2.ClassProtocol
@_exported import protocol TapAlertViewControllerV2.OrientationHandler

/// Objects that an report errors should conform to this protocol.
public protocol ErrorReporting: ClassProtocol {
	
	/// Language used in the alert to ask report.
	var language: String { get set }
	
	/// Defines if the receiver can report.
	var canReport: Bool { get }
	
	/// Reports an error.
	///
	/// - Parameters:
	///   - error: Error. Anything that can be serialized.
	///   - product: Product name.
	///   - productVersion: Product version.
	///   - alertOrientationHandler: Permissions alert orientation handler.
	func report(_ error: Encodable, in product: String, productVersion: String, alertOrientationHandler: OrientationHandler)
}
