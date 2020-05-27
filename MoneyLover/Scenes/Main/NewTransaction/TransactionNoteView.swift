//
//  TransactionNoteView.swift
//  MoneyLover
//
//  Created by Hoang Anh Tuan on 5/26/20.
//  Copyright © 2020 Hoang Anh Tuan. All rights reserved.
//

import UIKit

protocol TransactionNoteDelegate: NSObject {
    func didFinishInsertingNote(_ note: String)
}

class TransactionNoteView: UIViewController {
    // MARK: IBOutlet
    @IBOutlet weak var noteTextField: UITextField!
    
    weak var delegate: TransactionNoteDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteTextField.delegate = self
        noteTextField.becomeFirstResponder()
        
        navigationItem.title = "Ghi chú"
        let leftBarButton = UIBarButtonItem(title: "< Thêm giao dịch", style: .plain, target: self, action: #selector(didTapButtonBack))
        navigationItem.leftBarButtonItem = leftBarButton
    }
    
    @objc
    func didTapButtonBack() {
        navigationController?.popViewController(animated: true)
    }
}

extension TransactionNoteView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let noteString = textField.text {
            delegate?.didFinishInsertingNote(noteString)
            navigationController?.popViewController(animated: true)
        }
        
        return true
    }
}
