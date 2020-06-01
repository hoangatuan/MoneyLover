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
    @IBOutlet private weak var categoryName: UILabel!
    // 3
    @IBOutlet private weak var noteLabel: UILabel!
    // 4
    @IBOutlet private weak var dateLabel: UILabel!
    // 5
    @IBOutlet private weak var walletImageView: UIImageView!
    @IBOutlet private weak var walletNameLabel: UILabel!
    
    private var presenter: AddTransactionPresenter?
    var currentDate = Date()
    // MARK: -Initialize
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        presenter = AddTransactionPresenter(view: self)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        moneyTextField.isUserInteractionEnabled = true
        
        didFinishPickingDate(date: Date())
        
        // Just add logic for 1 wallet
        let defaultWallet = DatabaseManager.shared.getDefaultWallet()
        walletNameLabel.text = defaultWallet.name
    }
    
    private func setupNavigation() {
        navigationItem.title = "Thêm giao dịch"
        
        let leftBarButton = UIBarButtonItem(title: "Hủy", style: .plain, target: self, action: #selector(didTapButtonCancel))
        leftBarButton.tintColor = UIColor.green
        navigationItem.leftBarButtonItem = leftBarButton
        
        let rightBarButton = UIBarButtonItem(title: "Lưu", style: .plain, target: self, action: #selector(didTapButtonSave))
        rightBarButton.tintColor = UIColor.green
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc
    func didTapButtonCancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    func didTapButtonSave() {
        guard let moneyString = moneyTextField.text,
            let categoryName = categoryName.text,
            let money = Double(moneyString) else {
            return
        }
    
        presenter?.addNewTransaction(money: money, category: categoryName, note: noteLabel.text, date: currentDate)
        self.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            let categorySelectionView = StoryBoardManager.instanceCategorySelectionView()
            categorySelectionView.delegate = self
            navigationController?.pushViewController(categorySelectionView, animated: true)
        case 2:
            let transactionNoteView = StoryBoardManager.instanceTransactionNoteView()
            transactionNoteView.currentNote = noteLabel.text
            transactionNoteView.delegate = self
            navigationController?.pushViewController(transactionNoteView, animated: true)
        case 3:
            let datePickerView = StoryBoardManager.instanceDatePickerView()
            datePickerView.delegate = self
            navigationController?.pushViewController(datePickerView, animated: true)
        case 4:
            return
        default:
            tableView.deselectRow(at: indexPath, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension AddTransactionView: IAddTransactionView {
    func didFinishCreateNewTransaction(_ transaction: Transaction) {
        
    }
}

extension AddTransactionView: CategorySelectionDelegate {
    func didFinishPickingCategory(category: Category) {
        let image = UIImage(named: category.imageName)
        categoryImageView.image = image
        categoryName.text = category.name
    }
}

extension AddTransactionView: TransactionNoteDelegate {
    func didFinishInsertingNote(_ note: String) {
        noteLabel.text = note
    }
}

extension AddTransactionView: DatePickerDelegate {
    func didFinishPickingDate(date: Date) {
        currentDate = date
        var dateString = ""
        switch date.weekDay {
        case 2:
            dateString += "Thứ Hai,"
        case 3:
            dateString += "Thứ Ba,"
        case 4:
            dateString += "Thứ Tư,"
        case 5:
            dateString += "Thứ Năm,"
        case 6:
            dateString += "Thứ Sáu,"
        case 7:
            dateString += "Thứ Bảy,"
        case 8:
            dateString += "Chủ Nhật,"
        default:
            dateString = ""
        }

        dateString += " \(date.day) tháng \(date.month) \(date.year)"
        dateLabel.text = dateString
    }
}
