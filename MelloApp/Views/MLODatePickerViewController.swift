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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nextViewController = segue.destination as? MLOListOptionViewController else { return }
        nextViewController.view.layoutIfNeeded()
        nextViewController.type = .timeOfDay
    }
}
