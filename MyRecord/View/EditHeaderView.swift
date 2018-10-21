//
//  EditHeaderView.swift
//  MyRecord
//
//  Created by hao on 2018/10/19.
//  Copyright © 2018年 gaorhao. All rights reserved.
//

import UIKit
import AudioToolbox

class EditHeaderView: HeaderView {
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        addObserver(self, forKeyPath: "state", options: [.new, .old], context: nil)
    }
    
    deinit {
        removeObserver(self, forKeyPath: "state")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        if let keypath = keyPath {
            if keypath.isEqual("state") {
                if let state = change?[NSKeyValueChangeKey.newKey] as? state {
                    switch state {
                    case .Showing:
                        AudioServicesPlaySystemSound(1519)
                        
                        NotificationCenter.default.post(name: .headerViewDidShowingNotification, object: nil, userInfo: nil)
                        break
                    case .Hide:
                        break
                    }
                }
            }
        }
    }
    
}
