//
//  AddRecordViewController.swift
//  HDailyRecord
//
//  Created by hao on 2018/10/17.
//  Copyright © 2018年 gaorhao. All rights reserved.
//

import UIKit

protocol AddRecordViewControllerDelegate {
    func addRecordViewControllerDidClickedDismissButton(viewController: AddRecordViewController)
}

class AddRecordViewController: BaseViewController {
    var delegate: AddRecordViewControllerDelegate?
    private var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.cornerRadius = 20
        
        textField = UITextField.init(frame: CGRect(x: 20, y: 80, width: view.width -  40, height: 40))
        textField.delegate = self
        view.addSubview(textField)
        
        let line = UIView(frame: CGRect(x: 20, y: textField.frame.maxY, width: textField.frame.width, height:  1 / UIScreen.main.scale))
        line.backgroundColor = UIColor.black
        view.addSubview(line)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        textField.endEditing(true)
    }
}

extension AddRecordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let store = RecordStore.shared
        if let title = textField.text {
            store.append(item: .init(title: title))
            
            delegate?.addRecordViewControllerDidClickedDismissButton(viewController: self)
        }
        return true
    }
}
