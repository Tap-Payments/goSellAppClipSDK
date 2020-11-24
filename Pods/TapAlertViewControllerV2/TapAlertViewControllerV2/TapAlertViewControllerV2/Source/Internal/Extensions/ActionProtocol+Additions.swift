//
//  ActionProtocol+Additions.swift
//  TapAlertViewController
//
//  Copyright © 2019 Tap Payments. All rights reserved.
//

extension ActionProtocol {
	
	// MARK: - Internal -
	// MARK: Properties
	
	internal var buttonCellStyle: ButtonCellStyle {
		
		if self is TapAlertDoubleAction {
		
			return .double
		}
		else if self is TapAlertAction {
			
			return .single
		}
		else {
			
			fatalError("ActionProtocol must not be adopted by custom classes.")
		}
	}
}
