//
//  LoginViewController.swift
//  MelloApp
//
//  Created by Suraya Shivji on 2/5/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
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
        
        // Remove "back" title from navigation bar for next segue
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        passwordTextField.delegate = self
        emailTextField.delegate = self
        
        self.hideKeyboardWhenTappedAround()
        
        let logo = UIImage(named: "navlogo.png")
        self.navigationItem.titleView = UIImageView(image: logo)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Text Field Delegate
    func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    // MARK: Actions
    @IBAction func loginTapped(_ sender: Any) {
        if let (email, password) = validateLoginText() {
            manager.loginUser(withEmail: email, password: password, completion: { [weak self] (user, error) in
                if let error = error {
                    self?.manager.handle(error: error, completion: { (title, description) in
                        guard let title = title, let description = description else { return }
                        self?.alertUserOf(title: title, message: description, completion: {_ in })
                    })
                }
                
                // Segue to home
                if let loginHome = MLODrawerController.setupDrawer() {
                    self?.present(loginHome, animated: true, completion: nil)
                }
            })
        }
    }
    
    // MARK: Private Functions
    private func validateLoginText() -> (emailText: String, passwordText: String)? {
        guard let email = emailTextField.text else {
            print("Email is nil")
            alertUserOf(title: "Enter Email", message: "Please enter an email address.", completion: {_ in })
            return nil
        }
        guard !email.isEmpty else {
            print("Email is nil")
            alertUserOf(title: "Enter Email", message: "Please enter an email address.", completion: {_ in })
            return nil
        }
        guard let password = passwordTextField.text else {
            print("Password is nil")
            alertUserOf(title: "Enter Password", message: "Please enter a password.", completion: {_ in })
            return nil
        }
        guard !password.isEmpty else {
            print("Password is nil")
            alertUserOf(title: "Enter Password", message: "Please enter a password.", completion: {_ in })
            return nil
        }
        return (email, password)
    }
}
