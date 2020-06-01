//
//  MonthTransaction+CoreDataProperties.swift
//  MoneyLover
//
//  Created by Hoang Anh Tuan on 5/26/20.
//  Copyright © 2020 Hoang Anh Tuan. All rights reserved.
//
//

import Foundation
import CoreData


extension MonthTransaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MonthTransaction> {
        return NSFetchRequest<MonthTransaction>(entityName: "MonthTransaction")
    }

    @NSManaged public var month: Int16
    @NSManaged public var year: Int16
    @NSManaged public var dayTransactions: NSSet?
    @NSManaged public var wallet: Wallet
    @NSManaged public var moneyIn: Double
    @NSManaged public var moneyOut: Double
}

// MARK: Generated accessors for dayTransactions
extension MonthTransaction {

    @objc(addDayTransactionsObject:)
    @NSManaged public func addToDayTransactions(_ value: DayTransaction)

    @objc(removeDayTransactionsObject:)
    @NSManaged public func removeFromDayTransactions(_ value: DayTransaction)

    @objc(addDayTransactions:)
    @NSManaged public func addToDayTransactions(_ values: NSSet)

    @objc(removeDayTransactions:)
    @NSManaged public func removeFromDayTransactions(_ values: NSSet)

}
