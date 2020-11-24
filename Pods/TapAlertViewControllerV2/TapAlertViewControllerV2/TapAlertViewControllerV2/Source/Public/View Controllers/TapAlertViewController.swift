//
//  TapAlertViewController.swift
//  TapAlertViewController
//
//  Copyright © 2019 Tap Payments. All rights reserved.
//

import struct	CoreGraphics.CGGeometry.CGSize
import class	TapAdditionsKitV2.SeparateWindowRootViewController
import struct	TapAdditionsKitV2.TypeAlias
import class	TapVisualEffectViewV2.TapVisualEffectView
import class	UIKit.NSLayoutConstraint.NSLayoutConstraint
import class	UIKit.UILabel.UILabel
import class	UIKit.UIStoryboard.UIStoryboard
import class	UIKit.UITableView.UITableView
import class	UIKit.UIView.UIView
import class	UIKit.UIViewController.UIViewController
import class	UIKit.UIWindow.UIWindow

#if !swift(>=4.2)
import var		UIKit.UIWindow.UIWindowLevelStatusBar
#endif

/// Replacement for UIAlertViewController that looks like the native one, but allows to customize.
public class TapAlertViewController: UIViewController {
	
	// MARK: - Public -
	
	public typealias Action	= ActionProtocol
	
	// MARK: Properties
	
	public override var title: String? {
		
		didSet {
			
			self.updateTitleText()
		}
	}
	
	/// Message.
	public var message: String? {
		
		didSet {
			
			self.updateMessageText()
		}
	}
	
	/// Actions
	public private(set) var actions: [Action] {
		
		get {
		
			return self.buttonsHandler.actions
		}
		set {
		
			self.buttonsHandler.actions = newValue
		}
	}
	
	public var customView: UIView? {
		
		didSet {
			
			self.updateCustomView()
		}
	}
	
	// MARK: Methods
	
	/// Initializes an alert with the title and action.
	///
	/// - Parameters:
	///   - title: Title.
	///   - message: Message.
	public static func with(title: String? = nil, message: String? = nil) -> TapAlertViewController {
		
		let controller = TapAlertViewController.intantiateFromStoryboard()
		
		controller.title					= title
		controller.message					= message
		controller.transitioningDelegate	= controller.transitionsHandler
		
		return controller
	}
	
	/// Adds an action.
	///
	/// - Parameter action: Action to add.
	public func add(action: Action) {
		
		guard !self.actions.contains(where: { $0 === action }) else { return }
		
		self.actions.append(action)
	}
	
	/// Removes action.
	///
	/// - Parameter action: Action to remove.
	public func remove(action: Action) {
		
		self.actions.removeAll(where: { $0 === action })
	}
	
	public func show(orientationHandler: OrientationHandler = AlertOrientationHandler.shared) {
		
		let appearanceClosure: TypeAlias.GenericViewControllerClosure<SeparateWindowRootViewController> = { rootController in
			
			let supportedOrientations	= orientationHandler.supportedInterfaceOrientations(for: rootController)
			let canAutorotate			= orientationHandler.viewControllerShouldAutorotate(rootController)
			let preferredOrientation	= orientationHandler.preferredInterfaceOrientationForPresentation(of: rootController)
			
			rootController.canAutorotate					= canAutorotate
			rootController.allowedInterfaceOrientations		= supportedOrientations
			rootController.preferredInterfaceOrientation	= preferredOrientation
			
			rootController.present(self, animated: true, completion: nil)
		}
		
		DispatchQueue.main.async {
			
			#if swift(>=4.2)
			let windowLevel: UIWindow.Level	= .statusBar
			#else
			let windowLevel: UIWindow.Level = UIWindowLevelStatusBar
			#endif
			
			self.tap_showOnSeparateWindow(below: windowLevel, using: appearanceClosure)
		}
	}
	
	public func hide(_ completion: TypeAlias.ArgumentlessClosure? = nil) {
		
		DispatchQueue.main.async {
			
			self.tap_dismissFromSeparateWindow(true, completion: completion)
		}
	}
	
	// MARK: - Internal -
	// MARK: Properties
	
	@IBOutlet internal private(set) weak var backgroundView: UIView?
	@IBOutlet internal private(set) weak var contentView: UIView?
	
	// MARK: - Private -
	// MARK: Properties
	
	@IBOutlet private weak var customViewContainer: UIView? {
		
		didSet {
			
			self.updateCustomView()
		}
	}
	
	@IBOutlet private weak var contentBlurView: TapVisualEffectView? {
		
		didSet {
			
			if #available(iOS 10.0, *) {
				
				self.contentBlurView?.style = .prominent
			}
			else {
				
				self.contentBlurView?.style = .extraLight
			}
		}
	}
	
	@IBOutlet private weak var titleLabel: UILabel? {
		
		didSet {
			
			self.updateTitleText()
		}
	}
	
	@IBOutlet private weak var messageLabel: UILabel? {
		
		didSet {
			
			self.updateMessageText()
		}
	}
	
	@IBOutlet private weak var buttonsTableView: UITableView? {
		
		didSet {
			
			self.buttonsHandler.tableView = self.buttonsTableView
		}
	}
	
	@IBOutlet private weak var buttonsTableViewHeightConstraint: NSLayoutConstraint? {
		
		didSet {
			
			self.updateButtonsHeight(with: self.buttonsTableView?.contentSize ?? .zero)
		}
	}
	
	private lazy var buttonsHandler: ButtonsTableViewHandler = {
		
		let handler = ButtonsTableViewHandler()
		handler.delegate = self
		
		return handler
		
	}()
	
	private lazy var transitionsHandler = TransitionsHandler()
	
	// MARK: Methods
	
	private static func intantiateFromStoryboard() -> TapAlertViewController {
		
		guard let result = UIStoryboard.tap_controllers.instantiateViewController(withIdentifier: self.tap_className) as? TapAlertViewController else {
			
			fatalError("Failed to instantiate \(self.tap_className) from storyboard.")
		}
		
		return result
	}
	
	private func updateButtonsHeight(with size: CGSize) {
		
		DispatchQueue.main.async {
			
			guard let constraint = self.buttonsTableViewHeightConstraint, size.height != constraint.constant else { return }
			
			constraint.constant = size.height
			self.view.tap_layout()
		}
	}
	
	private func updateTitleText() {
		
		self.titleLabel?.text = self.title
	}
	
	private func updateMessageText() {
		
		self.messageLabel?.text = self.message
	}
	
	private func updateCustomView() {
		
		guard let container = self.customViewContainer else { return }
		
		while container.subviews.count > 0 { container.subviews.first?.removeFromSuperview() }
		
		if let newCustomView = self.customView {
			
			container.tap_addSubviewWithConstraints(newCustomView)
		}
	}
}

// MARK: - ButtonsTableViewHandler.Delegate
extension TapAlertViewController: ButtonsTableViewHandler.Delegate {
	
	internal func buttonsTableViewHandler(_ buttonsTableViewHandler: ButtonsTableViewHandler, tableViewContentSizeChangedTo size: CGSize) {
		
		self.updateButtonsHeight(with: size)
	}
}

// MARK: - TransitionsHandlerSupport
extension TapAlertViewController: TransitionsHandlerSupport {}
