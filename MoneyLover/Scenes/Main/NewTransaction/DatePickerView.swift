//
//  DatePickerView.swift
//  MoneyLover
//
//  Created by Hoang Anh Tuan on 5/27/20.
//  Copyright © 2020 Hoang Anh Tuan. All rights reserved.
//

import UIKit

protocol DatePickerDelegate: NSObjectProtocol {
    func didFinishPickingDate(date: DateComponents)
}

class DatePickerView: UIViewController {
    @IBOutlet private weak var datePickerView: UIDatePicker!
    weak var delegate: DatePickerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
    }
    
    private func setupNavigation() {
        let leftBarButton = UIBarButtonItem(title: "< Thêm giao dịch", style: .plain, target: self, action: #selector(didTapButtonBack))
        navigationItem.leftBarButtonItem = leftBarButton
        
        let rightBarButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(didTapButtonDone))
        navigationItem.rightBarButtonItem = rightBarButton
    }

    @objc
    func didTapButtonBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func didTapButtonDone() {
        let components = Calendar.current.dateComponents([.year, .month, .day, .weekday], from: datePickerView.date)
        delegate?.didFinishPickingDate(date: components)
        navigationController?.popViewController(animated: true)
    }
}
