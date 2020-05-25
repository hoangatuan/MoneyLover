//
//  WalletTransactionView.swift
//  MoneyLover
//
//  Created by Hoang Anh Tuan on 5/24/20.
//  Copyright © 2020 Hoang Anh Tuan. All rights reserved.
//

import UIKit

class WalletTransactionView: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var transactionTableView: UITableView!

    // MARK: - Initialize
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        setupTableview()
    }
    
    private func setupTableview() {
        transactionTableView.dataSource = self
        transactionTableView.delegate = self
        transactionTableView.register(TransactionPerDayCell.nib, forCellReuseIdentifier: TransactionPerDayCell.nibName)
        transactionTableView.register(TransactionPerMonthCell.nib, forCellReuseIdentifier: TransactionPerMonthCell.nibName)
        
        transactionTableView.rowHeight = UITableView.automaticDimension
        transactionTableView.estimatedRowHeight = 600
    }
}

extension WalletTransactionView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: TransactionPerMonthCell.nibName, for: indexPath) as! TransactionPerMonthCell
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: TransactionPerDayCell.nibName, for: indexPath) as! TransactionPerDayCell
        }
        
        return cell
    }
}

extension WalletTransactionView: UITableViewDelegate {
    
}
