//
//  CustomNavigationBar.swift
//  MoneyLover
//
//  Created by Hoang Anh Tuan on 5/24/20.
//  Copyright © 2020 Hoang Anh Tuan. All rights reserved.
//

import UIKit

class CustomNavigationBar: UIView {
    // MARK: IBOutlets
    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var currentMoneyLabel: UILabel!
    
    // MARK: Initialize
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(CustomNavigationBar.nibName, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
