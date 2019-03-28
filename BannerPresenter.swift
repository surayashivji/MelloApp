//
//  BannerPresenter.swift
//  MelloApp
//
//  Created by Harrison Weinerman on 3/26/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

/// Manages presentation/dismissal of banners
class BannerPresenter {
    /// Singleton instance
    static let shared = BannerPresenter()
    /// Banner that is on screen now
    private var presentedBanner: UIView?
    /// Constraint pinning bottom of banner to bottom of screen
    private var bottomConstraint: NSLayoutConstraint?
    /// Height of banner
    private let height: CGFloat = 81
    /// After this many seconds, banners automatically dismiss
    private let dismissAfter: TimeInterval = 3
    /// Timer used to automatically dismiss banners
    private var dismissTimer: Timer?
    /// Time to build in/out banners
    private let animationDuration = 0.3
    
    /// Presents a banner on the lower part of the screen with the given string and image
    func presentLower(text: NSAttributedString, icon: UIImage) {
        dismissTimer?.invalidate()
        guard let root = topViewController() else { return }
        // If we've presentede a banner, dismiss it first before presenting another one
        if let _ = presentedBanner {
            dismiss {
                self.presentLower(text: text, icon: icon)
            }
            return
        }
        
        let banner = UIView()
        banner.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                           action: #selector(bannerManuallyDismissed)))
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self,
                                                              action: #selector(bannerManuallyDismissed))
        swipeGestureRecognizer.direction = .down
        banner.addGestureRecognizer(swipeGestureRecognizer)
        banner.translatesAutoresizingMaskIntoConstraints = false
        banner.backgroundColor = .coolOffWhite
        
        let iconImageView = UIImageView(image: icon)
        let label = UILabel()
        
        label.attributedText = text
        label.translatesAutoresizingMaskIntoConstraints = false
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.contentMode = .scaleAspectFit
        
        root.view.addSubview(banner)
        banner.addSubview(iconImageView)
        banner.addSubview(label)
        
        iconImageView.addConstraints([
            NSLayoutConstraint(item: iconImageView,
                               attribute: .height,
                               relatedBy: .equal,
                               toItem: nil,
                               attribute: .notAnAttribute,
                               multiplier: 1,
                               constant: 18),
            NSLayoutConstraint(item: iconImageView,
                               attribute: .width,
                               relatedBy: .equal,
                               toItem: nil,
                               attribute: .notAnAttribute,
                               multiplier: 1,
                               constant: 18)])
        banner.addConstraints([
            NSLayoutConstraint(item: banner,
                               attribute: .leading,
                               relatedBy: .equal,
                               toItem: iconImageView,
                               attribute: .leading,
                               multiplier: 1,
                               constant: -32),
            NSLayoutConstraint(item: banner,
                               attribute: .centerY,
                               relatedBy: .equal,
                               toItem: iconImageView,
                               attribute: .centerY,
                               multiplier: 1,
                               constant: 0),
            NSLayoutConstraint(item: banner,
                               attribute: .centerY,
                               relatedBy: .equal,
                               toItem: label,
                               attribute: .centerY,
                               multiplier: 1,
                               constant: 0),
            NSLayoutConstraint(item: banner,
                               attribute: .trailing,
                               relatedBy: .greaterThanOrEqual,
                               toItem: label,
                               attribute: .trailing,
                               multiplier: 1,
                               constant: 5)
            ])
        banner.addConstraint(NSLayoutConstraint(item: iconImageView,
                                                       attribute: .trailing,
                                                       relatedBy: .equal,
                                                       toItem: label,
                                                       attribute: .leading,
                                                       multiplier: 1,
                                                       constant: -17))
        let bottomConstraint = NSLayoutConstraint(item: root.view,
                                                  attribute: .bottom,
                                                  relatedBy: .equal,
                                                  toItem: banner,
                                                  attribute: .bottom,
                                                  multiplier: 1,
                                                  constant: -height)
        self.bottomConstraint = bottomConstraint
        root.view.addConstraints([
            NSLayoutConstraint(item: root.view,
                               attribute: .leading,
                               relatedBy: .equal,
                               toItem: banner,
                               attribute: .leading,
                               multiplier: 1,
                               constant: 0),
            NSLayoutConstraint(item: root.view,
                               attribute: .trailing,
                               relatedBy: .equal,
                               toItem: banner,
                               attribute: .trailing,
                               multiplier: 1,
                               constant: 0),
            bottomConstraint
            ])
        banner.addConstraint(NSLayoutConstraint(item: banner,
                                                attribute: .height,
                                                relatedBy: .equal,
                                                toItem: nil,
                                                attribute: .notAnAttribute,
                                                multiplier: 1,
                                                constant: height))
        root.view.layoutIfNeeded()
        bottomConstraint.constant = 0
        UIView.animate(withDuration: animationDuration) {
            root.view.layoutIfNeeded()
        }
        
        // Dismiss automatically
        dismissTimer = Timer.scheduledTimer(withTimeInterval: dismissAfter, repeats: false, block: { timer in
            self.dismiss()
            timer.invalidate()
        })
        presentedBanner = banner
    }
    
    /// Dismisses the currently presented banner
    func dismiss(completion: (() -> Void)? = nil) {
        guard let root = topViewController() else { return }
        bottomConstraint?.constant = -height
        UIView.animate(withDuration: animationDuration, animations: {
            root.view.layoutIfNeeded()
        }) { _ in
            self.presentedBanner?.removeFromSuperview()
            self.presentedBanner = nil
            completion?()
        }
    }
    
    /// When the banner is tapped/swiped
    @objc private func bannerManuallyDismissed() {
        dismiss()
    }
    
    /// Fetches the topmost view controller in the window to present banners onto
    /// Adapted from SO: https://stackoverflow.com/questions/6131205/iphone-how-to-find-topmost-view-controller
    private func topViewController() -> UIViewController? {
        guard let window = UIApplication.shared.keyWindow, let rootViewController = window.rootViewController else {
            return nil
        }
        
        var topController = rootViewController
        while let newTopController = topController.presentedViewController {
            topController = newTopController
        }
        return topController
    }
}
