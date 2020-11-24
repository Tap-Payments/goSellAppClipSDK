//
//  TapAlertDoubleAction.swift
//  TapAlertViewController
//
//  Copyright © 2019 Tap Payments. All rights reserved.
//

/// Double action. Represents two actions next each to other in UI.
public class TapAlertDoubleAction: ActionProtocol {
	
	// MARK: - Public -
	// MARK: Properties
	
	/// Leading action.
	public let leadingAction: TapAlertAction
	
	/// Trailing action.
	public let trailingAction: TapAlertAction
	
	// MARK: Methods
	
	/// Initializes double action with leading and trailing actions.
	///
	/// - Parameters:
	///   - leadingAction: Leading action.
	///   - trailingAction: Trailing action.
	public init(leadingAction: TapAlertAction, trailingAction: TapAlertAction) {
		
		self.leadingAction	= leadingAction
		self.trailingAction	= trailingAction
	}
}
