//
//  DoubleActionTableViewCell.swift
//  TapAlertViewController
//
//  Copyright © 2019 Tap Payments. All rights reserved.
//

import class	UIKit.UIButton.UIButton

internal final class DoubleActionTableViewCell: ActionTableViewCell {
	
	// MARK: - Internal -
	// MARK: Properties
	
	internal weak var secondAction: TapAlertAction? {
		
		didSet {
			
			self.secondAction?.button = self.secondButton
		}
	}
	
	// MARK: Methods
	
	internal override func setup(with action: ActionProtocol) {
		
		guard let doubleAction = action as? TapAlertDoubleAction else {
			
			fatalError("Unknown action: \(action)")
		}
		
		self.secondAction = doubleAction.trailingAction
		
		super.setup(with: action)
	}
	
	// MARK: - Private -
	// MARK: Properties
	
	@IBOutlet private weak var secondButton: UIButton? {
		
		didSet {
			
			self.secondAction?.button = self.secondButton
		}
	}
	
	@IBAction private func secondButtonTouchUpInsdie(_ sender: Any) {
		
		guard let nonnullSecondAction = self.secondAction else { return }
		
		self.delegate?.actionCell(self, buttonClickedFor: nonnullSecondAction)
	}
}
