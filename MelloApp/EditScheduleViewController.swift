//
//  EditScheduleViewController.swift
//  MelloApp
//
//  Created by Harrison Weinerman on 5/6/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

class EditScheduleViewController: UIViewController {
    
    var presenter: UIViewController?
    @IBOutlet weak var cardView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardView.layer.cornerRadius = 30
        cardView.layer.masksToBounds = true
    }
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func unschedule(_ sender: Any) {
        
    }
    
    @IBAction func edit(_ sender: Any) {
        dismiss(animated: true, completion: {
            guard let scheduler = self.storyboard?
                .instantiateViewController(withIdentifier: "scheduler") else { return }
            self.presenter?.present(scheduler, animated: true, completion: nil)
        })
    }
}
