//
//  MLOOnboardingViewController.swift
//  MelloApp
//
//  Created by Harrison Weinerman on 3/11/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

class MLOOnboardingNavigationController: UINavigationController {
    let progressIndicator = MLOProgressCircle()
    override func viewDidLoad() {
        super.viewDidLoad()
        progressIndicator.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.addSubview(progressIndicator)
        navigationBar.addConstraints([
            NSLayoutConstraint(item: navigationBar,
                               attribute: .leading,
                               relatedBy: .equal,
                               toItem: progressIndicator,
                               attribute: .leading,
                               multiplier: 1,
                               constant: -20),
            NSLayoutConstraint(item: navigationBar,
                               attribute: .centerY,
                               relatedBy: .equal,
                               toItem: progressIndicator,
                               attribute: .centerY,
                               multiplier: 1,
                               constant: 0)
            ])
        
        progressIndicator.addConstraints([
            NSLayoutConstraint(item: progressIndicator,
                               attribute: .width,
                               relatedBy: .equal,
                               toItem: nil,
                               attribute: .notAnAttribute,
                               multiplier: 1,
                               constant: 16),
            NSLayoutConstraint(item: progressIndicator,
                               attribute: .height,
                               relatedBy: .equal,
                               toItem: nil,
                               attribute: .notAnAttribute,
                               multiplier: 1,
                               constant: 16)
            ])
    }
    
    private var progressPerPage: Double {
        return 1.0 / Double(MLOSelectableOptionType.allOptions.count + 2)
    }
    
    func incrementProgressIndicator() {
        progressIndicator.setProgress(to: progressIndicator.progress + progressPerPage,
                                      withAnimation: true)
    }
    
    func decrementProgressIndicator() {
        progressIndicator.setProgress(to: progressIndicator.progress - progressPerPage,
                                      withAnimation: true)
    }
}
