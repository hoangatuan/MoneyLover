//
//  TransactionPerDayCell.swift
//  MoneyLover
//
//  Created by Hoang Anh Tuan on 5/25/20.
//  Copyright © 2020 Hoang Anh Tuan. All rights reserved.
//

import UIKit

class TransactionPerDayCell: UITableViewCell {
    // MARK: IBOutlet
    @IBOutlet private weak var transactionPerDayCollection: TransactionPerDayCollectionView!
    
    // MARK: Constant
    let heightCell: CGFloat = 60.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        transactionPerDayCollection.register(TransactionCell.nib, forCellWithReuseIdentifier: TransactionCell.nibName)
        transactionPerDayCollection.dataSource = self
        transactionPerDayCollection.delegate = self
        transactionPerDayCollection.layoutIfNeeded()
    }
}

extension TransactionPerDayCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TransactionCell.nibName, for: indexPath) as! TransactionCell
        return cell
    }
}

extension TransactionPerDayCell: UICollectionViewDelegate {
    
}

extension TransactionPerDayCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: heightCell)
    }
}
