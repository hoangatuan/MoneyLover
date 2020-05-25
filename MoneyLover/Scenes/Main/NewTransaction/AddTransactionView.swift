//
//  AddTransactionView.swift
//  MoneyLover
//
//  Created by Hoang Anh Tuan on 5/25/20.
//  Copyright © 2020 Hoang Anh Tuan. All rights reserved.
//

import UIKit

class AddTransactionView: UITableViewController {
    // MARK: - IBOutlets
    // 1
    @IBOutlet private weak var moneyUnitImageView: UIImageView!
    @IBOutlet private weak var moneyTextField: UITextField!
    // 2
    @IBOutlet private weak var categoryImageView: UIImageView!
    // 3
    @IBOutlet private weak var noteLabel: UILabel!
    // 4
    @IBOutlet private weak var dateLabel: UILabel!
    // 5
    @IBOutlet private weak var walletImageView: UIImageView!
    @IBOutlet private weak var walletNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
    }
    
    private func setupNavigation() {
        navigationItem.title = "Thêm giao dịch"
        
        let leftBarButton = UIBarButtonItem(title: "Hủy", style: .plain, target: self, action: #selector(didTapButtonCancel))
        leftBarButton.tintColor = UIColor.green
        navigationItem.leftBarButtonItem = leftBarButton
    }
    
    @objc
    func didTapButtonCancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            return
        case 1:
            let categorySelectionView = StoryBoardManager.instanceCategorySelectionView()
            navigationController?.pushViewController(categorySelectionView, animated: true)
        case 2:
            return
        case 3:
            return
        case 4:
            return
        default:
            return
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
