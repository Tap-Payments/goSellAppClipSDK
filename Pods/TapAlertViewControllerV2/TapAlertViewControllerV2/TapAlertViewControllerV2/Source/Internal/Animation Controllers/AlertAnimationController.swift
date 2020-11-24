//
//  AlertAnimationController.swift
//  TapAlertViewController
//
//  Copyright © 2019 Tap Payments. All rights reserved.
//

import CoreGraphics
import class	QuartzCore.CAAnimation.CAKeyframeAnimation
import struct	TapAdditionsKitV2.TypeAlias
import class	UIKit.UIView.UIView
import protocol	UIKit.UIViewControllerTransitioning.UIViewControllerAnimatedTransitioning
import protocol	UIKit.UIViewControllerTransitioning.UIViewControllerContextTransitioning

internal final class AlertAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
	
	// MARK: - Internal -
	
	internal enum Operation {
		
		case appearance
		case disappearance
	}
	
	// MARK: Properties
	
	internal let operation: Operation
	
	// MARK: Methods
	
	internal init(of operation: Operation) {
		
		self.operation = operation
	}
	
	internal func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		
		if transitionContext?.isAnimated ?? false {
			
			switch self.operation {
				
			case .appearance:		return Constants.appearanceDuration
			case .disappearance:	return Constants.disappearanceDuration
				
			}
		}
		else {
			
			return 0.0
		}
	}
	
	internal func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
		
		var alertController: TapAlertViewController
		if let alert = transitionContext.viewController(forKey: .to) as? TapAlertViewController, self.operation == .appearance {
			
			alertController = alert
		}
		else if let alert = transitionContext.viewController(forKey: .from) as? TapAlertViewController, self.operation == .disappearance {
			
			alertController = alert
		}
		else {
			
			return
		}
		
		guard let fromView = transitionContext.view(forKey: .from), let toView = transitionContext.view(forKey: .to) else { return }
		let containerView = transitionContext.containerView
		let animationDuration = self.transitionDuration(using: transitionContext)
		
		var initialBackgroundAlpha: CGFloat
		var finalBackgroundAlpha: CGFloat
		var zoomAnimation: CAKeyframeAnimation
		
		switch self.operation {
			
		case .appearance:
			
			containerView.addSubview(fromView)
			containerView.addSubview(toView)
			
			initialBackgroundAlpha	= 0.0
			finalBackgroundAlpha	= 1.0
			zoomAnimation			= .tap_alertAppearance(with: animationDuration)
			
		case .disappearance:
			
			containerView.addSubview(toView)
			containerView.addSubview(fromView)
			
			initialBackgroundAlpha	= 1.0
			finalBackgroundAlpha	= 0.0
			zoomAnimation			= .tap_alertDisappearance(with: animationDuration)
		}
		
		alertController.backgroundView?.alpha = initialBackgroundAlpha
		
		let animations: TypeAlias.ArgumentlessClosure = {
			
			UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1.0, animations: {
				
				alertController.backgroundView?.alpha = finalBackgroundAlpha
				alertController.contentView?.layer.add(zoomAnimation, forKey: Constants.zoomAnimationKey)
			})
		}
		
		UIView.animateKeyframes(withDuration: animationDuration, delay: 0.0, options: [], animations: animations) { (_) in
			
			transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
		}
	}
	
	// MARK: - Private -
	
	private struct Constants {
		
		fileprivate static let appearanceDuration: TimeInterval = 0.18
		fileprivate static let disappearanceDuration: TimeInterval = 0.18
		fileprivate static let zoomAnimationKey: String = "zoom_animation"
		
		@available(*, unavailable) private init() { fatalError("This struct cannot be instantiated.") }
	}
}
