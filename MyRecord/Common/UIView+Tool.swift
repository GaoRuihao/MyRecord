//
//  UIView+Tool.swift
//  MyRecord
//
//  Created by hao on 2018/10/17.
//  Copyright © 2018年 gaorhao. All rights reserved.
//

import UIKit

extension UIView {
    var x: CGFloat {
        get {
            return bounds.origin.x
        }
        set {
            bounds.origin.x = x
        }
    }
    
    var y: CGFloat {
        get {
            return bounds.origin.y
        }
        set {
            bounds.origin.y = y
        }
    }
    
    var width: CGFloat {
        get {
            return bounds.size.width
        }
        set {
            bounds.size.width = width
        }
    }
    
    var height: CGFloat {
        get {
            return bounds.size.height
        }
        set {
            bounds.size.height = height
        }
    }
    
}
