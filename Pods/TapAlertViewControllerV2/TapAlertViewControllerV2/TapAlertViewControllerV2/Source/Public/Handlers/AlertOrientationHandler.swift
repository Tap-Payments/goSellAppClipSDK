//
//  AlertOrientationHandler.swift
//  TapAlertViewController
//
//  Copyright © 2019 Tap Payments. All rights reserved.
//

import class	UIKit.UIApplication.UIApplication
import enum		UIKit.UIApplication.UIInterfaceOrientation
import struct	UIKit.UIApplication.UIInterfaceOrientationMask
import class	UIKit.UIViewController.UIViewController

/// Default implementation of alert orientation handler.
public class AlertOrientationHandler: OrientationHandler {
	
	// MARK: - Public -
	// MARK: Properties
	
	/// Shared instance.
	public static let shared = AlertOrientationHandler()
	
	// MARK: Methods
	
	public func viewControllerShouldAutorotate(_ controller: UIViewController) -> Bool {
		
		return true
	}
	
	public func supportedInterfaceOrientations(for controller: UIViewController) -> UIInterfaceOrientationMask {
		
		return .all
	}
	
	public func preferredInterfaceOrientationForPresentation(of controller: UIViewController) -> UIInterfaceOrientation {
		
		return UIApplication.shared.statusBarOrientation
	}
	
	// MARK: - Private -
	// MARK: Methods
	
	private init() {}
}
