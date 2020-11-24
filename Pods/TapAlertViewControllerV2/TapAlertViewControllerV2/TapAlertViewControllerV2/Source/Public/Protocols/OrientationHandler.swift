//
//  OrientationHandler.swift
//  TapAlertViewController
//
//  Copyright © 2019 Tap Payments. All rights reserved.
//

import enum		UIKit.UIApplication.UIInterfaceOrientation
import struct	UIKit.UIApplication.UIInterfaceOrientationMask
import class	UIKit.UIViewController.UIViewController

/// Interface to handle permission alert orientation.
public protocol OrientationHandler {
	
	/// Defines if `controller` should autorotate.
	///
	/// - Parameter controller: View controller
	/// - Returns: Bool
	func viewControllerShouldAutorotate(_ controller: UIViewController) -> Bool
	
	/// Returns supported unterface orientation mask for the given `controller`
	///
	/// - Parameter controller: View controller
	/// - Returns: UIInterfaceOrientationMask
	func supportedInterfaceOrientations(for controller: UIViewController) -> UIInterfaceOrientationMask
	
	/// Returns preferred interface orientation for presentation of given `controller`.
	///
	/// - Parameter controller: View controller.
	/// - Returns: UIInterfaceOrientation
	func preferredInterfaceOrientationForPresentation(of controller: UIViewController) -> UIInterfaceOrientation
}
