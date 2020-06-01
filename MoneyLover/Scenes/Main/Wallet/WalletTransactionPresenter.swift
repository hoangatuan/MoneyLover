//
//  WalletTransactionPresenter.swift
//  MoneyLover
//
//  Created by Hoang Anh Tuan on 6/1/20.
//  Copyright © 2020 Hoang Anh Tuan. All rights reserved.
//

import Foundation

class WalletTransactionPresenter {
    func findMonthTransaction(month: Int, year: Int) -> MonthTransaction? {
        return DatabaseManager.shared.getMonthTransaction(month: month, year: year)
    }
}
