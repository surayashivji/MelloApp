//
//  ModalPresentationAnimationVC.swift
//  MelloApp
//
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

class ModalPresentationAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    var reversed: Bool = false
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toView = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)?.view,
            let fromView = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)?.view else { return }
        
        let containerView = transitionContext.containerView
        
        print("Gen...", toView.bounds.size.height, containerView.bounds.size.height, fromView.bounds.size.height)
        if !reversed {
            toView.frame = containerView.bounds
            containerView.addSubview(toView)
            
            let transform: CGAffineTransform = toView.transform
            toView.transform = transform.translatedBy(x: 0, y: containerView.bounds.size.height)
            
            UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3, options: [], animations: {
                toView.transform = transform
            }) { (_) in
                transitionContext.completeTransition(true)
            }
        } else {
            UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3, options: [], animations: {
                fromView.center = CGPoint(x: fromView.center.x, y: containerView.frame.size.height + toView.frame.size.height)
            }) { (_) in
                transitionContext.completeTransition(true)
            }
        }
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.8
    }
}
