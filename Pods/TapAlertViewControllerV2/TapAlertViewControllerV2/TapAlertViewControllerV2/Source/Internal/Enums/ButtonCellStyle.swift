//
//  ButtonCellStyle.swift
//  TapAlertViewController
//
//  Copyright © 2019 Tap Payments. All rights reserved.
//

internal enum ButtonCellStyle {
	
	case single
	case double
	
	// MARK: - Internal -
	// MARK: Properties
	
	internal var cellReuseIdentifier: String {
		
		switch self {
			
		case .single:
			
			return ActionTableViewCell.tap_className
			
		case .double:
			
			return DoubleActionTableViewCell.tap_className
		}
	}
}
