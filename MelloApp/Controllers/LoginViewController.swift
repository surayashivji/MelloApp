//
//  LoginViewController.swift
//  MelloApp
//
//  Created by Suraya Shivji on 2/5/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: Setup
    let manager = FirebaseManager()
    
    // MARK: Outlets
    @IBOutlet weak var passwordTextField: CustomTextField!
    @IBOutlet weak var emailTextField: CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Make navigation bar transparent
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    @IBAction func loginTapped(_ sender: Any) {
        if let (email, password) = validateLoginText() {
            manager.loginUser(withEmail: email, password: password, completion: { [weak self] (user, error) in
                if let error = error {
                    self?.manager.handle(error: error)
                    // TODO: error handling for login cases in manager
                }
                // Login Success
                guard let user = user else { return } // FIRUser
                print("\(user.email?.description): signed in.")
                // TODO: segue home
            })
        }
    }
    
    @IBAction func forgotTapped(_ sender: Any) {
        if let (email, _) = validateLoginText() {
            manager.resetPasswordWithEmail(email: email, completion: { [weak self] (error) in
                if let error = error {
                    self?.manager.handle(error: error)
                    // TODO: error handling for forgot password cases in firebase manager - failed to reset?
                    print("fail to reset")
                } else {
                    // success
                    // email sent
                    print("success to reset")
                    self?.alertUserOf(title: "Password Request Sent", message: "Check your email for the link to reset your password.")
                }
            })
        }
    }
    
    // MARK: Private Functions
    
    private func validateLoginText() -> (emailText: String, passwordText: String)? {
        guard let email = emailTextField.text else {
            print("Email is nil")
            alertUserOf(title: "Enter Email", message: "Please enter an email address.")
            return nil
        }
        guard !email.isEmpty else {
            print("Email is nil")
            alertUserOf(title: "Enter Email", message: "Please enter an email address.")
            return nil
        }
        guard let password = passwordTextField.text else {
            print("Password is nil")
            alertUserOf(title: "Enter Password", message: "Please enter a password.")
            return nil
        }
        guard !password.isEmpty else {
            print("Password is nil")
            alertUserOf(title: "Enter Password", message: "Please enter a password.")
            return nil
        }
        return (email, password)
    }
}
