//
//  EditHeaderView.swift
//  MyRecord
//
//  Created by hao on 2018/10/19.
//  Copyright © 2018年 gaorhao. All rights reserved.
//

import UIKit
import AudioToolbox


protocol EditHeaderViewDelegate {
    func textFieldDidEndEditing()
}

class EditHeaderView: HeaderView {
    var pullingDidEnd: (() -> Void)?
    
    override var state: state {
        willSet {
            if self.state != newValue {
                switch newValue {
                case .Showing:
                    AudioServicesPlaySystemSound(1519)
                    break
                case .Hide:
                    self.pullingDidEnd?();
                    break
                }
            }
        }
    }
    
    var titleLabel: UILabel!
    let tfHeight: CGFloat = 40
    var delegate: EditHeaderViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let titleLabel = UILabel(frame: CGRect(x: 20, y: self.height - tfHeight, width: self.width, height: tfHeight))
        titleLabel.text = "下拉添加"
        self.addSubview(titleLabel)
        self.titleLabel = titleLabel
        let line = UIView(frame: CGRect(x: 20, y: titleLabel.frame.maxY, width: titleLabel.frame.width, height:  1 / UIScreen.main.scale))
        line.backgroundColor = UIColor.black
        self.addSubview(line)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
