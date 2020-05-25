//
//  StoryBoardManager.swift
//  MoneyLover
//
//  Created by Hoang Anh Tuan on 5/25/20.
//  Copyright © 2020 Hoang Anh Tuan. All rights reserved.
//

import UIKit

class StoryBoardManager {
    static let MainStoryBoard: String = "Main"
    
    static func instanceAddTransactionView() -> AddTransactionView {
        let storyboard = UIStoryboard(name: StoryBoardManager.MainStoryBoard, bundle: nil)
        let addTransactionView = storyboard.instantiateViewController(withIdentifier: AddTransactionView.identifier) as! AddTransactionView
        return addTransactionView
    }
    
    static func instanceCategorySelectionView() -> CategorySelectionView {
        let storyboard = UIStoryboard(name: StoryBoardManager.MainStoryBoard, bundle: nil)
        let categorySelectionView = storyboard.instantiateViewController(withIdentifier: CategorySelectionView.identifier) as! CategorySelectionView
        return categorySelectionView
    }
}
