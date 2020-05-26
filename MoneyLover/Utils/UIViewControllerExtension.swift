//
//  UIViewControllerExtension.swift
//  MoneyLover
//
//  Created by Hoang Anh Tuan on 5/25/20.
//  Copyright © 2020 Hoang Anh Tuan. All rights reserved.
//

import UIKit

extension UIViewController {
    class var identifier: String {
        return String(describing: self)
    }
}
