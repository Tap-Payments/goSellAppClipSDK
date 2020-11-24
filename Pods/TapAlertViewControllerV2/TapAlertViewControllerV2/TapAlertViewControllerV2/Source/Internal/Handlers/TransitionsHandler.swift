//
//  TransitionsHandler.swift
//  TapAlertViewController
//
//  Copyright © 2019 Tap Payments. All rights reserved.
//

import class	UIKit.UIViewController.UIViewController
import protocol	UIKit.UIViewControllerTransitioning.UIViewControllerAnimatedTransitioning
import protocol	UIKit.UIViewControllerTransitioning.UIViewControllerTransitioningDelegate

internal final class TransitionsHandler: NSObject, UIViewControllerTransitioningDelegate {
	
	// MARK: - Internal -
	// MARK: Methods
	
	internal func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		
		if presented is TapAlertViewController {
			
			return AlertAnimationController(of: .appearance)
		}
		else {
			
			return nil
		}
	}
	
	internal func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		
		if dismissed is TapAlertViewController {
			
			return AlertAnimationController(of: .disappearance)
		}
		else {
			
			return nil
		}
	}
}
