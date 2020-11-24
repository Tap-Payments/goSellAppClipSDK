//
//  UIStoryboard+Additions.swift
//  TapAlertViewController
//
//  Copyright © 2019 Tap Payments. All rights reserved.
//

import class	UIKit.UIStoryboard.UIStoryboard

internal extension UIStoryboard {
	
	// MARK: - Internal -
	// MARK: Properties
	
	static let tap_controllers = UIStoryboard(name: Constants.controllersStoryboardName, bundle: .tapAlertViewControllerResources)
	
	// MARK: - Private -
	
	private struct Constants {
		
		fileprivate static let controllersStoryboardName = "Controllers"
		
		@available(*, unavailable) private init() { fatalError("This struct cannot be instantiated.") }
	}
}
