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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(white: 243 / 255, alpha: 1.0)
        view.layer.cornerRadius = 20
        
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 80, y: 210, width: 160, height: 40)
        btn.setTitle("Dismiss me", for: .normal)
        btn.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        view.addSubview(btn)
    }
    
    @objc func buttonClick(_ sender: UIButton) {
        delegate?.addRecordViewControllerDidClickedDismissButton(viewController: self)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
