//
//  NormalDismissAnimation.swift
//  HDailyRecord
//
//  Created by hao on 2018/10/17.
//  Copyright © 2018年 gaorhao. All rights reserved.
//

import UIKit

class NormalDismissAnimation: NSObject {

}

extension NormalDismissAnimation: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) else { return }
        guard let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else { return }
        
        let initFrame = transitionContext.initialFrame(for: fromVC)
        let finalFrame = initFrame.offsetBy(dx: 0, dy: UIScreen.main.bounds.size.height)
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toVC.view)
        containerView.sendSubviewToBack(toVC.view)
        
        let duration = transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, animations: {
            fromVC.view.frame = finalFrame
        }) { (finished) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
}
