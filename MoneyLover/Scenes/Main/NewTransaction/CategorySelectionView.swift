//
//  CategorySelectionView.swift
//  MoneyLover
//
//  Created by Hoang Anh Tuan on 5/26/20.
//  Copyright © 2020 Hoang Anh Tuan. All rights reserved.
//

import UIKit
import CoreData

protocol CategorySelectionDelegate: NSObjectProtocol {
    func didFinishPickingCategory(category: Category)
}

class CategorySelectionView: UIViewController {
    // MARK: IBOutlet
    @IBOutlet private weak var categoryTableView: UITableView!
    @IBOutlet private weak var categoryTypeSegment: UISegmentedControl!
    
    // MARK: Variables
    weak var delegate: CategorySelectionDelegate?
    var categories: [Category] = []
    
    // MARK: Initialize
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        
        categoryTableView.dataSource = self
        categoryTableView.delegate = self
        
        categoryTypeSegment!.selectedSegmentIndex = 1
        categories = filterCategoryByType(type: 1)
    }
    
    private func filterCategoryByType(type: Int16) -> [Category] {
        let listCategories = DatabaseManager.shared.getListDefaultCategory().filter({ (category) -> Bool in
            category.type == type
        })
        return listCategories
    }
    
    private func setupNavigation() {
        navigationItem.title = "Chọn nhóm"
        
        let leftBarButton = UIBarButtonItem(title: "< Quay lại", style: .plain, target: self, action: #selector(didTapButtonDismiss))
        navigationItem.leftBarButtonItem = leftBarButton
    }
    
    @objc
    func didTapButtonDismiss() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didChangeCategoryType(_ sender: Any) {
        categories = filterCategoryByType(type: Int16(categoryTypeSegment!.selectedSegmentIndex))
        categoryTableView.reloadData()
    }
}

extension CategorySelectionView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let category = categories[indexPath.row]
        cell.imageView?.image = UIImage(named: category.imageName)
        cell.textLabel?.text = category.name
        return cell
    }
}

extension CategorySelectionView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didFinishPickingCategory(category: categories[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.popViewController(animated: true)
    }
}
