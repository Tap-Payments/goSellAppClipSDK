//
//  Bundle+ErrorReporting.swift
//  TapErrorReporting
//
//  Copyright © 2019 Tap Payments. All rights reserved.
//

internal extension Bundle {
	
	// MARK: - Internal -
	// MARK: Properties
	
	static let errorReportingResources: Bundle = {
		
		guard let result = Bundle(for: ErrorReporter.self).tap_childBundle(named: Constants.errorReportingResourcesBundleName) else {
			
			fatalError("There is no \(Constants.errorReportingResourcesBundleName) bundle.")
		}
		
		return result
	}()
	
	// MARK: - Private -
	
	private struct Constants {
		
		fileprivate static let errorReportingResourcesBundleName = "ErrorReportingResources"
		
		@available(*, unavailable) private init() {}
	}
}
