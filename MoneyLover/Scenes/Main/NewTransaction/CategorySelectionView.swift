//
//  CategorySelectionView.swift
//  MoneyLover
//
//  Created by Hoang Anh Tuan on 5/26/20.
//  Copyright © 2020 Hoang Anh Tuan. All rights reserved.
//

import UIKit

class CategorySelectionView: UIViewController {
    // MARK: IBOutlet
    @IBOutlet private weak var categoryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
    }
    
    private func setupNavigation() {
        navigationItem.title = "Chon nhom"
        
        let leftBarButton = UIBarButtonItem(title: "< Quay lại", style: .plain, target: self, action: #selector(didTapButtonDismiss))
        navigationItem.leftBarButtonItem = leftBarButton
    }
    
    @objc
    func didTapButtonDismiss() {
        navigationController?.popViewController(animated: true)
    }
    
}
