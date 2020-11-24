//
//  CardScannerViewController.swift
//  goSellSDK
//
//  Copyright © 2019 Tap Payments. All rights reserved.
//
import struct	CoreGraphics.CGGeometry.CGSize
import enum		UIKit.UIApplication.UIStatusBarStyle
import class	UIKit.UIScreen.UIScreen
import class	UIKit.UIViewController.UIViewController

import UIKit

internal class CardScannerViewController: HeaderNavigatedViewController {
    
    // MARK: - Internal -
    // MARK: Properties
	
	internal override var preferredStatusBarStyle: UIStatusBarStyle {
		
		return Theme.current.commonStyle.statusBar[.fullscreen].uiStatusBarStyle
	}
	
	internal override var preferredContentSize: CGSize {
		
		get {
			
			return UIScreen.main.bounds.size
		}
		set {
			
			super.preferredContentSize = UIScreen.main.bounds.size
		}
	}
    
    /// Delegate.
    internal weak var delegate: CardScannerViewControllerDelegate?
    
    // MARK: Methods
	
    // MARK: - Private -
    // MARK: Properties
}

// MARK: - TapNavigationView.DataSource
extension CardScannerViewController: TapNavigationView.DataSource {
	
	internal func navigationViewCanGoBack(_ navigationView: TapNavigationView) -> Bool {
		
		return (self.navigationController?.viewControllers.count ?? 0) > 1
	}
	
	internal func navigationViewIconPlaceholder(for navigationView: TapNavigationView) -> Image? {
		
		return nil
	}
	
	internal func navigationViewIcon(for navigationView: TapNavigationView) -> Image? {
		
		if let icon = Theme.current.paymentOptionsCellStyle.card.scanIcon {
			
			return .ready(icon)
		}
		else {
			
			return nil
		}
	}
	
	internal func navigationViewTitle(for navigationView: TapNavigationView) -> String? {
		
		return LocalizationManager.shared.localizedString(for: .card_scanning_screen_title)
	}
}
