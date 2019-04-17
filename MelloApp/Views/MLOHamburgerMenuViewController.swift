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
        let button = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"),
                                     landscapeImagePhone: #imageLiteral(resourceName: "menu"),
                                     style: .done,
                                     target: self,
                                     action: #selector(openDrawer))
        navigationItem.setLeftBarButton(button, animated: false)
        navigationController?.navigationBar.barTintColor = .mediumPurple
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
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
