//
//  ResetPasswordViewController.swift
//  MelloApp
//
//  Created by Suraya Shivji on 2/12/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

class ResetPasswordViewController: UIViewController {
    
    // MARK: Setup
    let manager = FirebaseManager()
    
    // MARK: Outlets
    @IBOutlet weak var emailTextField: CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Make navigation bar transparent
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
    }
    
    @IBAction func resetPasswordTapped(_ sender: Any) {
        if let email = validateResetText() {
            manager.resetPasswordWithEmail(email: email, completion: { [weak self] (error) in
                if let error = error {
                    self?.manager.handle(error: error)
                    // TODO: error handling for forgot password cases in firebase manager - failed to reset?
                    print("fail to reset")
                } else {
                    // success - email sent
                    self?.alertUserOf(title: "Password Request Sent", message: "Check your email for the link to reset your password.", completion: { (alert) in
                        // segue back to login
                        self?.navigationController?.popViewController(animated: true)
                    })
                }
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Private Functions
    private func validateResetText() -> String? {
        guard let email = emailTextField.text else {
            print("Email is nil")
            alertUserOf(title: "Enter Email", message: "Please enter an email address.", completion:{_ in })
            return nil
        }
        guard !email.isEmpty else {
            print("Email is nil")
            alertUserOf(title: "Enter Email", message: "Please enter an email address.", completion: {_ in })
            return nil
        }
        return email
    }
    
}
