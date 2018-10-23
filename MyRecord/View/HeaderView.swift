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
let kGHHDecelerating = "decelerating"

class HeaderView: UIView {
    enum state {
        case Showing
        case Hide
    }
    
    weak var scrollView: UIScrollView?
    
    var state: state = .Hide {
        willSet {
            switch newValue {
            case .Showing:
                
                break
            case .Hide:
                scrollView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                break
            }
        }
    }
    private var orginInset: UIEdgeInsets?
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        addObservers()
    }
    
    private func addObservers() {
        scrollView?.addObserver(self, forKeyPath: kGHHContentOffset, options: [.new, .old], context: nil)
        scrollView?.addObserver(self, forKeyPath: kGHHContentSize, options: [.new, .old], context: nil)
        scrollView?.addObserver(self, forKeyPath: kGHHDecelerating, options: [.new, .old], context: nil)
    }
    
    deinit {
        scrollView?.removeObserver(self, forKeyPath: kGHHContentOffset)
        scrollView?.removeObserver(self, forKeyPath: kGHHContentSize)
        scrollView?.removeObserver(self, forKeyPath: kGHHDecelerating)
        scrollView = nil
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let keyPath = keyPath {
            if keyPath.isEqual(kGHHContentOffset) {
                scrollViewContentOffsetDidChange()
            } else if keyPath.isEqual(kGHHDecelerating) {
                print("松开手指")
            }
        }
    }
    
    private func scrollViewContentOffsetDidChange() {
        print("scrollView: \(scrollView!.contentOffset.y)")
        guard let scrollView = scrollView else { return }
        if -scrollView.contentOffset.y >= self.height {
            let top = scrollView.contentInset.top + self.height
            
            var contentOffset = scrollView.contentOffset
            contentOffset.y = -top;
            self.scrollView?.setContentOffset(contentOffset, animated: false)
            self.state = .Showing
        } else {
            self.state = .Hide
        }
    }
    
}
