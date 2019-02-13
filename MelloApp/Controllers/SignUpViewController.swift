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
        
        // Remove "back" title from navigation bar for next segue
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    @IBAction func signUpTapped(_ sender: Any) {
        if let (name, email, password) = validateSignUpText() {
            manager.createUser(withEmail: email, password: password, completion: { [weak self] (user, error) in
                if let error = error {
                    self?.manager.handle(error: error)
                }
                guard let user = user else { return } // FIRUser
                print("user: \(user)")
                // success!
                // create user in database: name, email, date
                self?.manager.addUserToDB(uid: user.uid, name: name, email: email)
                // segue to onboarding
            })
        }
    }
    
    // MARK: Private Functions
    private func validateSignUpText() -> (nameText: String, emailText: String, passwordText: String)? {
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
        if password.count <= 6 {
            print("Password is too short")
            alertUserOf(title: "Password is Weak", message: "Password should be longer than 6 characters.")
            return nil
        }
        return (name, email, password)
    }

}
