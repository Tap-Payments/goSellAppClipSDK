//
//  ActionTableViewCell.swift
//  TapAlertViewController
//
//  Copyright © 2019 Tap Payments. All rights reserved.
//

import class	UIKit.NSLayoutConstraint.NSLayoutConstraint
import class	UIKit.UIButton.UIButton
import class	UIKit.UIScreen.UIScreen
import class	UIKit.UITableViewCell.UITableViewCell

internal class ActionTableViewCell: UITableViewCell {
	
	// MARK: - Internal -
	
	internal typealias Delegate = ActionTableViewCellDelegate
	
	// MARK: Properties
	
	internal weak var action: TapAlertAction? {
		
		didSet {
			
			self.action?.button = self.button
		}
	}
	
	internal weak var delegate: Delegate?
	
	// MARK: Methods
	
	internal func setup(with action: ActionProtocol) {
		
		if let doubleAction = action as? TapAlertDoubleAction {
			
			self.action = doubleAction.leadingAction
		}
		else if let singleAction = action as? TapAlertAction {
			
			self.action = singleAction
		}
		else {
			
			fatalError("Unknown action: \(action)")
		}
	}
	
	// MARK: - Private -
	// MARK: Properties
	
	@IBOutlet private weak var button: UIButton? {
		
		didSet {
			
			self.action?.button = self.button
		}
	}
	
	// MARK: Methods
	
	@IBAction private func buttonTouchUpInside(_ sender: Any) {
		
		guard let nonnullAction = self.action else { return }
		
		self.delegate?.actionCell(self, buttonClickedFor: nonnullAction)
	}
}
