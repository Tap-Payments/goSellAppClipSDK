//
//  DontAskMeAgainView.swift
//  TapAlertViewController
//
//  Copyright © 2019 Tap Payments. All rights reserved.
//

import struct	TapAdditionsKitV2.TypeAlias
import class	TapNibViewV2.TapNibView
import class	UIKit.UILabel.UILabel

internal final class DontAskMeAgainView: TapNibView {
	
	// MARK: - Internal -
	// MARK: Properties
	
	internal var isOn: Bool = false {
		
		didSet {
			
			self.updateState()
			
			self.changeClosure?(self.isOn)
		}
	}
	
	internal var text: String = .tap_empty {
		
		didSet {
			
			self.updateText()
		}
	}
	
	internal var changeClosure: TypeAlias.BooleanClosure?
	
	internal override class var bundle: Bundle {
		
		return .errorReportingResources
	}
	
	// MARK: Methods
	
	internal init(text: String, defaultValue: Bool, changeClosure: @escaping TypeAlias.BooleanClosure) {
		
		self.text			= text
		self.isOn			= defaultValue
		self.changeClosure	= changeClosure
		
		super.init(frame: .zero)
	}
	
	internal required init?(coder aDecoder: NSCoder) {
		
		super.init(coder: aDecoder)
	}
	
	// MARK: - Private -
	// MARK: Properties
	
	@IBOutlet private weak var textLabel: UILabel? {
		
		didSet {
			
			self.updateText()
		}
	}
	
	@IBOutlet private weak var checkmarkLabel: UILabel? {
		
		didSet {
			
			self.updateState()
		}
	}
	
	// MARK: Methods
	
	@IBAction private func buttonTouchUpInside(_ sender: Any) {
		
		self.isOn.toggle()
	}
	
	private func updateState() {
		
		self.checkmarkLabel?.isHidden = !self.isOn
	}
	
	private func updateText() {
		
		self.textLabel?.text = self.text
	}
}
