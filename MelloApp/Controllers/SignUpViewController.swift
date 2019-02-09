//
//  SignUpViewController.swift
//  MelloApp
//
//  Created by Suraya Shivji on 2/5/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    // MARK: Setup
    let manager = FirebaseManager()
    
    // MARK: Outlets
    @IBOutlet weak var nameTextField: CustomTextField!
    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!
    @IBOutlet weak var confirmPasswordTextField: CustomTextField!
    
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
    @IBAction func signUpTapped(_ sender: Any) {
        if let (email, password) = validateSignUpText() {
            manager.createUser(withEmail: email, password: password, completion: { [weak self] (user, error) in
                if let error = error {
                    self?.manager.handle(error: error)
                }
                guard let user = user else { return }
                // segue to onboarding
            })
        }
    }

    
    // MARK: Private Functions
    
    private func validateSignUpText() -> (emailText: String, passwordText: String)? {
        guard let name = nameTextField.text else {
            print("Name is nil")
            alertUserOf(title: "Enter Your Name", message: "Please enter your name.")
            return nil
        }
        guard !name.isEmpty else {
            print("Name is nil")
            alertUserOf(title: "Enter Your Name", message: "Please enter your name.")
            return nil
        }
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
        guard let confirmedPassword = confirmPasswordTextField.text else {
            print("Password is nil")
            alertUserOf(title: "Enter Password", message: "Please confirm your password.")
            return nil
        }
        if password != confirmedPassword {
            print("Password is nil")
            alertUserOf(title: "Passwords Do Not Match", message: "Please re-type password.")
            return nil
        }
        return (email, password)
    }
    
    private func alertUserOf(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }

}
