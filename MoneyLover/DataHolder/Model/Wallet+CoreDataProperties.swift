//
//  Wallet+CoreDataProperties.swift
//  MoneyLover
//
//  Created by Hoang Anh Tuan on 5/26/20.
//  Copyright © 2020 Hoang Anh Tuan. All rights reserved.
//
//

import Foundation
import CoreData


extension Wallet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Wallet> {
        return NSFetchRequest<Wallet>(entityName: "Wallet")
    }

    @NSManaged public var currentMoney: Double
    @NSManaged public var name: String
    @NSManaged public var monthTransactions: NSSet?

}

// MARK: Generated accessors for monthTransactions
extension Wallet {

    @objc(addMonthTransactionsObject:)
    @NSManaged public func addToMonthTransactions(_ value: MonthTransaction)

    @objc(removeMonthTransactionsObject:)
    @NSManaged public func removeFromMonthTransactions(_ value: MonthTransaction)

    @objc(addMonthTransactions:)
    @NSManaged public func addToMonthTransactions(_ values: NSSet)

    @objc(removeMonthTransactions:)
    @NSManaged public func removeFromMonthTransactions(_ values: NSSet)

}
