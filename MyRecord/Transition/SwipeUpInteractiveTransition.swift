//
//  SwipeUpInteractiveTransition.swift
//  HDailyRecord
//
//  Created by hao on 2018/10/17.
//  Copyright © 2018年 gaorhao. All rights reserved.
//

import UIKit

class SwipeUpInteractiveTransition: UIPercentDrivenInteractiveTransition {
    var interacting = false
    
    private var shouldComplete = false
    private var presentingVC: UIViewController?
    
    func wireToViewController(_ viewController: UIViewController) {
        presentingVC = viewController
        prepareGestureRecognizerInView(viewController.view)
    }
    
    func prepareGestureRecognizerInView(_ view: UIView) {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        view.addGestureRecognizer(gesture)
    }
    
    @objc func handleGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: gesture.view?.superview)
        switch gesture.state {
        case .began:
            interacting = true
            presentingVC?.dismiss(animated: true, completion: nil)
            break
        case .changed:
            var fraction = translation.y / 400.0
            fraction = CGFloat(fminf(fmaxf((Float(fraction)), 0.0), 1.0))
            shouldComplete = fraction > 0.5
            
            self.update(fraction)
            break
        case .ended, .cancelled:
            interacting = false
            if !shouldComplete || gesture.state == .cancelled {
                cancel()
            } else {
                finish()
            }
            break
        default:
            break
        }
    }
}

