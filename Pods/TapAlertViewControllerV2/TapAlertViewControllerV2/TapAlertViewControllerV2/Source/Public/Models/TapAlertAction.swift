//
//  TapAlertAction.swift
//  TapAlertViewController
//
//  Copyright © 2019 Tap Payments. All rights reserved.
//

/// Alert action.
public class TapAlertAction: ActionProtocol {
	
	// MARK: - Public -
	
	public typealias Style = TapAlertActionStyle
	
	/// Action click callback.
	public typealias ClickCallback = (TapAlertAction) -> Void
	
	// MARK: Properties
	
	/// Action button style.
	public var style: TapAlertActionStyle {
		
		didSet {
			
			guard self.style != oldValue else { return }
			self.updateButtonStyle()
		}
	}
	
	/// Action button title.
	public var title: String
	
	/// Click callback.
	public var clickCallback: ClickCallback
	
	// MARK: Methods
	
	public init(style: Style = .default, title: String, clickCallback: @escaping ClickCallback) {
		
		self.style			= style
		self.title			= title
		self.clickCallback	= clickCallback
	}
}
