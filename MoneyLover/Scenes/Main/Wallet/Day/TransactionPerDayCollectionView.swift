//
//  TransactionPerDayCollectionView.swift
//  MoneyLover
//
//  Created by Hoang Anh Tuan on 5/25/20.
//  Copyright © 2020 Hoang Anh Tuan. All rights reserved.
//

import UIKit

class TransactionPerDayCollectionView: UICollectionView {
    
    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
    }
    
    // Override this property to make collection view self sizing to show all cells.
    override var intrinsicContentSize: CGSize {
        return self.collectionViewLayout.collectionViewContentSize
    }
}
