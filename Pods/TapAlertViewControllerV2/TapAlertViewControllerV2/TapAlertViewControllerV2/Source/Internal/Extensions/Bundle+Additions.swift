//
//  Bundle+Additions.swift
//  TapAlertViewController
//
//  Copyright © 2019 Tap Payments. All rights reserved.
//

import class	Foundation.NSBundle.Bundle

internal extension Bundle {
	
	// MARK: - Internal -
	// MARK: Propeties
	
	static let tapAlertViewControllerResources: Bundle = {
		
		guard let result = Bundle(for: TapAlertViewController.self).tap_childBundle(named: Constants.tapAlertViewControllerResourcesBundleName) else {
			
			fatalError("There is no \(Constants.tapAlertViewControllerResourcesBundleName) bundle.")
		}
		
		return result
	}()
	
	// MARK: - Private -
	
	private struct Constants {
		
		fileprivate static let tapAlertViewControllerResourcesBundleName = "TapAlertViewControllerResources"
		
		@available(*, unavailable) private init() {}
	}
}
