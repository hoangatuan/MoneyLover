//
//  DateExtension.swift
//  MoneyLover
//
//  Created by Hoang Anh Tuan on 5/29/20.
//  Copyright © 2020 Hoang Anh Tuan. All rights reserved.
//

import Foundation

extension Date {
    var components: DateComponents {
        return Calendar.current.dateComponents([.year, .month, .day, .weekday], from: self)
    }
    
    var weekDay: Int {
        return components.weekday ?? 2
    }
    
    var day: Int {
        return components.day ?? 1
    }
    
    var month: Int {
        return components.month ?? 1
    }
    
    var year: Int {
         return components.year ?? 2000
    }
}
