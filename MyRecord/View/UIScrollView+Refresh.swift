//
//  UIScrollView+Refresh.swift
//  MyRecord
//
//  Created by hao on 2018/10/19.
//  Copyright © 2018年 gaorhao. All rights reserved.
//

import UIKit

extension NSObject {
    static func exchangeInstanceMethod(_ selector1: Selector, selector2: Selector) {
        guard let method1 = class_getInstanceMethod(self, selector1) else {return}
        guard let method2 = class_getInstanceMethod(self, selector2) else {return}
        method_exchangeImplementations(method1, method2)
    }
    
    static func exchangeClassMethod(_ selector1: Selector, selector2: Selector) {
        guard let method1 = class_getClassMethod(self, selector1) else {return}
        guard let method2 = class_getClassMethod(self, selector2) else {return}
        method_exchangeImplementations(method1, method2)
    }
}

extension UIScrollView {
    private static let kRefreshHeaderKey: UnsafeRawPointer? = UnsafeRawPointer(bitPattern: "\0".hashValue)
    private static let kRefreshFooterKey: UnsafeRawPointer? = UnsafeRawPointer(bitPattern: "\00".hashValue)
    
     var headerView: HeaderView? {
        set {
            if newValue != nil && headerView != newValue {
                newValue?.scrollView = self
                headerView?.removeFromSuperview()
                self.insertSubview(newValue!, at: 0)
                
                willChangeValue(forKey: "header")
                if let key = UIScrollView.kRefreshHeaderKey {
                    objc_setAssociatedObject(self, key, newValue!, .OBJC_ASSOCIATION_ASSIGN)
                }
                didChangeValue(forKey: "header")
            }
        }
        get {
            if let key = UIScrollView.kRefreshHeaderKey {
                return objc_getAssociatedObject(self, key) as? HeaderView
            }
            return nil
        }
    }
    
    var footView: FootView? {
        set {
            if newValue != nil && footView != newValue {
                footView?.removeFromSuperview()
                self.insertSubview(newValue!, at: 0)
                
                willChangeValue(forKey: "footer")
                if let key = UIScrollView.kRefreshFooterKey {
                    objc_setAssociatedObject(self, key, newValue!, .OBJC_ASSOCIATION_COPY_NONATOMIC)
                }
                didChangeValue(forKey: "footer")
            }
        }
        get {
            if let key = UIScrollView.kRefreshFooterKey {
                return objc_getAssociatedObject(self, key) as? FootView
            }
            return nil
        }
    }
}
