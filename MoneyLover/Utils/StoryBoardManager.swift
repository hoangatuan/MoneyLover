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
    
    static func instanceTransactionNoteView() -> TransactionNoteView {
        let storyboard = UIStoryboard(name: StoryBoardManager.MainStoryBoard, bundle: nil)
        let transactionNoteView = storyboard.instantiateViewController(withIdentifier: TransactionNoteView.identifier) as! TransactionNoteView
        return transactionNoteView
    }
    
    static func instanceDatePickerView() -> DatePickerView {
        let storyboard = UIStoryboard(name: StoryBoardManager.MainStoryBoard, bundle: nil)
        let datePickerView = storyboard.instantiateViewController(withIdentifier: DatePickerView.identifier) as! DatePickerView
        return datePickerView
    }
}
