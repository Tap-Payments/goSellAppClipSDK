//
//  TapAlertAction+Additions.swift
//  TapAlertViewController
//
//  Copyright © 2019 Tap Payments. All rights reserved.
//

import CoreGraphics
import class	UIKit.UIButton.UIButton
import class	UIKit.UIColor.UIColor
import class	UIKit.UIFont.UIFont

internal extension TapAlertAction {
	
	// MARK: - Internal -
	// MARK: Properties
	
	weak var button: UIButton? {
		
		get {
			
			return objc_getAssociatedObject(self, &AssociationKeys.button) as? UIButton
		}
		set {
			
			objc_setAssociatedObject(self, &AssociationKeys.button, newValue, .OBJC_ASSOCIATION_ASSIGN)
			
			self.updateButtonStyle()
		}
	}
	
	// MARK: Methods
	
	func updateButtonStyle() {
		
		guard let nonnullButton = self.button else { return }
		
		var tintColor: UIColor?
		var font: UIFont
		
		switch self.style {
			
		case .default:
			
			tintColor	= nil
			font		= .tap_alertNormalButtonFont
			
		case .bold:
			
			tintColor	= nil
			font		= .tap_alertBoldButtonFont
			
		case .destructive:
			
			tintColor	= .red
			font		= .tap_alertBoldButtonFont
		}
		
		nonnullButton.titleLabel?.font	= font
		nonnullButton.tintColor			= tintColor
		nonnullButton.setTitle(self.title, for: .normal)
	}
	
	// MARK: - Private -
	
	private struct AssociationKeys {
		
		fileprivate static var button: UInt8 = 0
		
		@available(*, unavailable) private init() { fatalError("This struct cannot be instantiated.") }
	}
}
