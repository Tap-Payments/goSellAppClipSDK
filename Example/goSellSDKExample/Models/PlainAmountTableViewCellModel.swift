//
//  PlainAmountTableViewCellModel.swift
//  goSellSDKExample
//
//  Copyright © 2019 Tap Payments. All rights reserved.
//

import struct   Foundation.NSDecimal.Decimal
import class    UIKit.UITableViewCell.UITableViewCell

internal protocol AmountChangeObserver {
    
    func amountChanged(_ amount: Decimal)
}

internal class PlainAmountTableViewCellModel: TableViewCellModel {
    
    // MARK: - Internal -
    // MARK: Properties
    
    internal let amountChangeObsever: AmountChangeObserver
    
    internal var amountString: String
    
    internal var amount: Decimal {
        
        return self.amountString.tap_decimalValue ?? 0
    }
    
    internal override class var cellClass: UITableViewCell.Type {
        
        return PlainAmountTableViewCell.self
    }
    
    // MARK: Methods
    
    internal init(amountString: String, changeObserver: AmountChangeObserver) {
        
        self.amountString = amountString
        self.amountChangeObsever = changeObserver
    }
}

// MARK: - PlainAmountTableViewCellTextChangeListener
extension PlainAmountTableViewCellModel: PlainAmountTableViewCellTextChangeListener {
    
    func textChanged(_ text: String) {
        
        self.amountString = text
        self.amountChangeObsever.amountChanged(self.amount)
    }
}
