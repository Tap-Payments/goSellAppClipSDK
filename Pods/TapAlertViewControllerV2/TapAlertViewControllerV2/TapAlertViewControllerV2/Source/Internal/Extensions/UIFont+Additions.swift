//
//  UIFont+Additions.swift
//  TapAlertViewController
//
//  Copyright © 2019 Tap Payments. All rights reserved.
//

import class	UIKit.UIFont.UIFont

internal extension UIFont {
	
	// MARK: - Internal -
	// MARK: Properties
	
	static let tap_alertNormalButtonFont: UIFont	= .systemFont(ofSize: .tap_alertButtonFontSize)
	static let tap_alertBoldButtonFont: UIFont		= {
		
		if #available(iOS 8.2, *) {
			
			return .systemFont(ofSize: .tap_alertButtonFontSize, weight: .semibold)
		}
		else {
			
			return .boldSystemFont(ofSize: .tap_alertButtonFontSize)
		}
	}()
}
