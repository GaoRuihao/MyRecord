//
//  AddRecordPresentingAnimation.swift
//  HDailyRecord
//
//  Created by hao on 2018/10/17.
//  Copyright © 2018年 gaorhao. All rights reserved.
//

import UIKit

class BouncePresentAnimation: NSObject {

}

extension BouncePresentAnimation: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else { return }
        guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) else { return }
        
        let fromView = fromVC.view.snapshotView(afterScreenUpdates: true)
        
        var finalFrame = transitionContext.finalFrame(for: toVC)
        toVC.view.frame = finalFrame.offsetBy(dx: 0, dy: UIScreen.main.bounds.size.height)
        finalFrame = finalFrame.offsetBy(dx: 0, dy: 180)
        
        let containerView = transitionContext.containerView
        if let tempView = fromView {
            containerView.addSubview(tempView)
        }
        containerView.addSubview(toVC.view)
        
        let duration = transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseIn, animations: {
            toVC.view.frame = finalFrame
        }) { (finished) in
            transitionContext.completeTransition(true)
            if transitionContext.transitionWasCancelled {
                fromVC.view.isHidden = false
                fromView?.removeFromSuperview()
            }
        }
        
    }
    
    
}


