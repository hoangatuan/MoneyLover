//
//  DayTransaction+CoreDataProperties.swift
//  MoneyLover
//
//  Created by Hoang Anh Tuan on 5/26/20.
//  Copyright © 2020 Hoang Anh Tuan. All rights reserved.
//
//

import Foundation
import CoreData


extension DayTransaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DayTransaction> {
        return NSFetchRequest<DayTransaction>(entityName: "DayTransaction")
    }

    @NSManaged public var day: Int16
    @NSManaged public var monthTransaction: MonthTransaction
    @NSManaged public var transactions: NSSet?

}

// MARK: Generated accessors for transactions
extension DayTransaction {

    @objc(addTransactionsObject:)
    @NSManaged public func addToTransactions(_ value: Transaction)

    @objc(removeTransactionsObject:)
    @NSManaged public func removeFromTransactions(_ value: Transaction)

    @objc(addTransactions:)
    @NSManaged public func addToTransactions(_ values: NSSet)

    @objc(removeTransactions:)
    @NSManaged public func removeFromTransactions(_ values: NSSet)

}
