//
//  MLODatePickerViewController.swift
//  MelloApp
//
//  Created by Harrison Weinerman on 3/9/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

class MLODatePickerViewController: UIViewController {

    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        let nextButton = UIBarButtonItem(title: "NEXT",
                                         style: .done,
                                         target: self,
                                         action: #selector(nextButtonTapped))
        nextButton.tintColor = .white
        navigationItem.setRightBarButton(nextButton,
                                         animated: false)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationItem.hidesBackButton = true
    }
    
    @objc private func nextButtonTapped() {
       performSegue(withIdentifier: "next", sender: self)
    }
}
