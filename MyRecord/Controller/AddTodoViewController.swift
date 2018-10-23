//
//  AddTodoViewController.swift
//  MyRecord
//
//  Created by hao on 2018/10/22.
//  Copyright © 2018年 gaorhao. All rights reserved.
//

import UIKit

class AddTodoViewController: BaseViewController {

    var textField: UITextField!
    private let tfHeight: CGFloat = 40
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let textField = UITextField(frame: CGRect(x: 20, y: self.view.height - tfHeight, width: self.view.width, height: tfHeight))
        textField.delegate = self
        textField.placeholder = "下拉添加"
        textField.backgroundColor = UIColor.red
        view.addSubview(textField)
        self.textField = textField
        let line = UIView(frame: CGRect(x: 20, y: textField.frame.maxY, width: textField.frame.width, height:  1 / UIScreen.main.scale))
        line.backgroundColor = UIColor.black
        view.addSubview(line)
    }

}

extension AddTodoViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.placeholder = "我想..."
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let store = RecordStore.shared
        if let title = textField.text {
            store.append(item: .init(title: title))
            
        }
        return true
    }
}
