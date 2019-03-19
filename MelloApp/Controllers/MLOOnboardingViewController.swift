//
//  MLOOnboardingViewController.swift
//  MelloApp
//
//  Created by Harrison Weinerman on 3/10/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

/// Intended to be subclassed. Sets up basic styling for an onboarding VC
class MLOOnboardingViewController: UIViewController {
    /// The sequence of this page among onboarding pages. Used to calculate progress and determine position
    var pageNumber = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        let nextButton = UIBarButtonItem(title: "NEXT",
                                         style: .done,
                                         target: self,
                                         action: #selector(nextButtonTapped))
        
        let font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        let attributes = [NSAttributedStringKey.foregroundColor: UIColor.white,
                          NSAttributedStringKey.font: font,
                          NSAttributedStringKey.paragraphStyle: NSMutableParagraphStyle()]
        nextButton.setTitleTextAttributes(attributes, for: .normal)
        nextButton.tintColor = .white
        navigationItem.setRightBarButton(nextButton,
                                         animated: false)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    @objc func nextButtonTapped() {
        incrementProgress()
    }
    
    func incrementProgress() {
        if let navigationController = navigationController as? MLOOnboardingNavigationController {
            navigationController.incrementProgressIndicator()
        }
    }
}
