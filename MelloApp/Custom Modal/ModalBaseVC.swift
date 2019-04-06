//
//  ModalBaseVC.swift
//  MelloApp
//
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

class ModalBaseViewController: UIViewController {
    var viewHeight: CGFloat?
    var viewCornerRadius: CGFloat?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self
    }
}

extension ModalBaseViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ModalPresentationAnimationController()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = ModalPresentationAnimationController()
        animator.reversed = true
        return animator
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = ModalPresentationController(presentedViewController: presented, presenting: presenting)
        presentationController.viewHeight = viewHeight
        presentationController.viewCornerRadius = viewCornerRadius
        return presentationController
    }
}
