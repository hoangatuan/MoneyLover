//
//  TransactionCell.swift
//  MoneyLover
//
//  Created by Hoang Anh Tuan on 5/24/20.
//  Copyright © 2020 Hoang Anh Tuan. All rights reserved.
//

import UIKit

class TransactionCell: UICollectionViewCell {
    // MARK: - IBOutlets
    @IBOutlet private weak var categoryImageView: UIImageView!
    @IBOutlet private weak var categoryNameLabel: UILabel!
    @IBOutlet private weak var noteLabel: UILabel!
    @IBOutlet private weak var moneyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
