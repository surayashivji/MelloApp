//
//  MLOOnboardingFinishViewController.swift
//
//  Created by Harrison Weinerman on 3/19/19.
//

import UIKit

class MLOOnboardingFinishViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.shadowImage = UIImage()
        (navigationController as? MLOOnboardingNavigationController)?.progressIndicator.isHidden = true
    }

}
