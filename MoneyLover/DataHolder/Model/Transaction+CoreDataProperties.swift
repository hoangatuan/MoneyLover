//
//  Transaction+CoreDataProperties.swift
//  MoneyLover
//
//  Created by Hoang Anh Tuan on 5/26/20.
//  Copyright © 2020 Hoang Anh Tuan. All rights reserved.
//
//

import Foundation
import CoreData


extension Transaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction")
    }

    @NSManaged public var id: Int16
    @NSManaged public var money: Double
    @NSManaged public var note: String?
    @NSManaged public var category: Category?
    @NSManaged public var dayTransaction: DayTransaction?

}
