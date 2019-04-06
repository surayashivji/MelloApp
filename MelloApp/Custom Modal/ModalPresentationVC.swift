//
//  ModalPresentationVC.swift
//  MelloApp
//
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

class ModalPresentationController: UIPresentationController {
    var viewHeight: CGFloat?
    var viewCornerRadius: CGFloat?
    
    lazy var dimmingView: UIView = {
        guard let containerView = self.containerView else { return UIView() }
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        
        let instanceView = UIView()
        instanceView.addGestureRecognizer(tap)
        instanceView.frame = containerView.bounds
        instanceView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.55)
        return instanceView
    }()
    
    override func presentationTransitionWillBegin() {
        guard let presentedView = self.presentedViewController.view,
            let containerView = containerView else { return }
        
        presentedView.layer.cornerRadius = viewCornerRadius ?? 30.0
        presentedView.layer.shadowColor = UIColor.black.cgColor
        presentedView.layer.shadowOffset = CGSize(width: 0, height: 10)
        presentedView.layer.shadowRadius = 10
        presentedView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        presentedView.layer.shadowOpacity = 0.5
        
        self.dimmingView.frame = containerView.bounds
        self.dimmingView.alpha = 0
        self.containerView?.addSubview(self.dimmingView)
        
        if let transitionCoordinator = presentedViewController.transitionCoordinator {
            transitionCoordinator.animate(alongsideTransition: { (_) in
                self.dimmingView.alpha = 1
            }, completion: nil)
        }
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        if !completed {
            self.dimmingView.removeFromSuperview()
        }
    }
    
    override func dismissalTransitionWillBegin() {
        if let transitionCoordinator = presentedViewController.transitionCoordinator {
            transitionCoordinator.animate(alongsideTransition: { (_) in
                self.dimmingView.alpha = 0
            }, completion: nil)
        }
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            self.dimmingView.removeFromSuperview()
        }
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerFrame = self.containerView?.frame else { return CGRect() }
        let frame = CGRect(x: 0, y: containerFrame.height - (viewHeight ?? 390), width: containerFrame.width, height: (viewHeight ?? 390))
        return frame
    }
    
    override func containerViewWillLayoutSubviews() {
        guard let containerBounds = self.containerView?.bounds else { return }
        self.dimmingView.frame = containerBounds
        self.presentedView?.frame = self.frameOfPresentedViewInContainerView
    }
}

extension ModalPresentationController {
    @objc
    func didTapView() {
        self.presentedViewController.view.endEditing(true)
        self.presentedViewController.dismiss(animated: true, completion: nil)
    }
}
