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
    var event: ScheduledBlend?
    
    @IBOutlet weak var cardView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardView.layer.cornerRadius = 30
        cardView.layer.masksToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.bringSubview(toFront: cardView)
    }
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func unschedule(_ sender: Any) {
        if let event = event {
            FirebaseManager.instance.unschedule(event: event)
        }
        dismiss(animated: true)
    }
    
    @IBAction func edit(_ sender: Any) {
        dismiss(animated: true, completion: {
            guard let scheduler = self.storyboard?
                .instantiateViewController(withIdentifier: "scheduler") else { return }
            self.presenter?.present(scheduler, animated: true, completion: nil)
        })
    }
}
