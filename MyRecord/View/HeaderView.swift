//
//  HeaderView.swift
//  MyRecord
//
//  Created by hao on 2018/10/19.
//  Copyright © 2018年 gaorhao. All rights reserved.
//

import UIKit

let kGHHContentOffset  = "contentOffset"
let kGHHContentSize = "contentSize"

class HeaderView: UIView {
    enum state {
        case Showing
        case Hide
    }
    
    weak var scrollView: UIScrollView?
    
    private var state: state = .Hide
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        addObservers()
    }
    
    private func addObservers() {
        scrollView?.addObserver(self, forKeyPath: kGHHContentOffset, options: [.new, .old], context: nil)
        scrollView?.addObserver(self, forKeyPath: kGHHContentSize, options: [.new, .old], context: nil)
    }
    
    deinit {
        scrollView?.removeObserver(self, forKeyPath: kGHHContentOffset)
        scrollView?.removeObserver(self, forKeyPath: kGHHContentSize)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let keyPath = keyPath {
            if keyPath.isEqual(kGHHContentOffset) {
                scrollViewContentOffsetDidChange()
            }
        }
    }
    
    private func scrollViewContentOffsetDidChange() {
        if scrollView!.contentOffset.y < CGFloat(-150) && self.state == .Hide {
            let contentOffset = scrollView!.contentOffset
            scrollView?.contentInset = UIEdgeInsets(top: 80, left: 0, bottom: 0, right: 0)
            scrollView?.setContentOffset(contentOffset, animated: false)
            self.state = .Showing
        }
    }
    
}
