//
//  AddTransactionPresenter.swift
//  MoneyLover
//
//  Created by Hoang Anh Tuan on 5/29/20.
//  Copyright © 2020 Hoang Anh Tuan. All rights reserved.
//

import Foundation

protocol IAddTransactionView: NSObjectProtocol {
    func didFinishCreateNewTransaction(_ transaction: Transaction)
}

class AddTransactionPresenter {
    
    init(view: IAddTransactionView) {
        self.delegate = view
    }
    
    weak var delegate: IAddTransactionView?
    
    func addNewTransaction(money: Double, category: String, note: String?, date: Date) {
        var newTransaction: Transaction
        var dayTransaction = DatabaseManager.shared.getDayTransaction(date: date)
        guard let category = DatabaseManager.shared.findCategoryByName(name: category) else {
            return
        }
        
        if dayTransaction == nil {
            let monthTransaction = DatabaseManager.shared.newMonthTransaction(month: date.month, year: date.year)
            dayTransaction = DatabaseManager.shared.newDayTransaction(day: date.day, monthTransaction: monthTransaction)
        }
        
        newTransaction = DatabaseManager.shared.newTransaction(money: money,
                                                               note: note,
                                                               weekDay: date.weekDay,
                                                               category: category,
                                                               dayTransaction: dayTransaction!)
        delegate?.didFinishCreateNewTransaction(newTransaction)
    }
}
