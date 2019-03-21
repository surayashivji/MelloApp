//
//  MLOHamburgerMenuViewController.swift
//  MelloApp
//
//  Created by Harrison Weinerman on 3/21/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

class MLOHamburgerMenuViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIBarButtonItem(image: #imageLiteral(resourceName: "checkmark"),
                                     landscapeImagePhone: #imageLiteral(resourceName: "checkmark"),
                                     style: .done,
                                     target: self,
                                     action: #selector(openDrawer))
        navigationItem.setLeftBarButton(button, animated: false)
    }
    
    @objc private func openDrawer() {
        guard let side = MLODrawerController.drawer?.openSide else { return }
        switch side {
        case .left:
            MLODrawerController.drawer?.closeDrawer(animated: true, completion: nil)
        default:
            MLODrawerController.drawer?.open(.left, animated: true, completion: nil)
        }
    }
}
