//
//  CAKeyframeAnimation+Additions.swift
//  TapAlertViewController
//
//  Copyright © 2019 Tap Payments. All rights reserved.
//

import class	QuartzCore.CAAnimation.CAKeyframeAnimation
import func		QuartzCore.CATransform3D.CATransform3DMakeScale

#if !swift(>=4.2)
import var			QuartzCore.CAMediaTiming.kCAFillModeForwards
#endif

internal extension CAKeyframeAnimation {
	
	// MARK: - Internal -
	// MARK: Methods
	
	static func tap_alertAppearance(with duration: TimeInterval) -> CAKeyframeAnimation {
		
		let animation = CAKeyframeAnimation(keyPath: Constants.transformKeyPath)
		animation.values = [
		
			NSValue(caTransform3D: CATransform3DMakeScale(1.2, 1.2, 1.0)),
			NSValue(caTransform3D: CATransform3DMakeScale(1.0, 1.0, 1.0))
		]
		
		animation.keyTimes = [0.0, 1.0]
		
		#if swift(>=4.2)
		animation.fillMode = .forwards
		#else
		animation.fillMode = kCAFillModeForwards
		#endif
		
		animation.isRemovedOnCompletion = false
		animation.duration = duration
		
		return animation
	}
	
	static func tap_alertDisappearance(with duration: TimeInterval) -> CAKeyframeAnimation {
		
		let animation = CAKeyframeAnimation(keyPath: Constants.opacityKeyPath)
		
		animation.values = [1.0, 0.0]
		
		animation.keyTimes = [0.0, 1.0]
		
		#if swift(>=4.2)
		animation.fillMode = .forwards
		#else
		animation.fillMode = kCAFillModeForwards
		#endif
		
		animation.isRemovedOnCompletion = false
		animation.duration = duration
		
		return animation
	}
	
	// MARK: - Private -
	
	private struct Constants {
		
		fileprivate static let opacityKeyPath	= "opacity"
		fileprivate static let transformKeyPath = "transform"
		
		@available(*, unavailable) private init() { fatalError("This struct cannot be instantiated.") }
	}
}
