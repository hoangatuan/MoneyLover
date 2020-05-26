//
//  BaseTabBarController.swift
//  MoneyLover
//
//  Created by Hoang Anh Tuan on 5/25/20.
//  Copyright © 2020 Hoang Anh Tuan. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
}

extension BaseTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if tabBarController.selectedIndex == 1 {
            tabBarController.selectedIndex = 0 
            let addTransationView = StoryBoardManager.instanceAddTransactionView()
            let navController = UINavigationController(rootViewController: addTransationView)
            navController.modalPresentationStyle = .fullScreen
            present(navController, animated: true)
        }
    }
}
