//
//  Status+CoreDataProperties.swift
//  MoneyLover
//
//  Created by Hoang Anh Tuan on 5/26/20.
//  Copyright © 2020 Hoang Anh Tuan. All rights reserved.
//
//

import Foundation
import CoreData


extension Status {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Status> {
        return NSFetchRequest<Status>(entityName: "Status")
    }

    @NSManaged public var moneyIn: Double
    @NSManaged public var moneyOut: Double
    @NSManaged public var monthTransaction: MonthTransaction?

}
