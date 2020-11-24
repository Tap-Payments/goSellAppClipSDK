//
//  CellViewModel.swift
//  goSellSDK
//
//  Copyright © 2019 Tap Payments. All rights reserved.
//

import class UIKit.UITableView.UITableView

import UIKit

internal class CellViewModel: ViewModel {
    
    // MARK: - Internal -
    // MARK: Properties
    
    internal var indexPath: IndexPath
    
    // MARK: Methods
    
    internal init(indexPath: IndexPath) {
        
        self.indexPath = indexPath
    }
}
