//
//  CollectionViewCellViewModel.swift
//  goSellSDK
//
//  Copyright © 2019 Tap Payments. All rights reserved.
//

import class    UIKit.UICollectionView.UICollectionView

import UIKit

internal class CollectionViewCellViewModel: CellViewModel {
    
    // MARK: - Internal -
    // MARK: Properties
    
    internal weak var collectionView: UICollectionView?
    
    // MARK: Methods
    
    internal func collectionViewDidSelectCell(_ sender: UICollectionView) { }
    
    internal func collectionViewDidDeselectCell(_ sender: UICollectionView) { }
}
