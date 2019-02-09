//
//  FirebaseManager.swift
//  MelloApp
//
//  Created by Suraya Shivji on 2/8/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit
import Firebase

class FirebaseManager {
    
    // MARK: - Properties
    var user: User? {
        return Auth.auth().currentUser
    }
    
    var signedIn: Bool {
        if let _ = Auth.auth().currentUser {
            return true
        } else {
            return false
        }
    }
    
    var reference: DatabaseReference {
        return Database.database().reference()
    }
    
    static let instance = FirebaseManager()
    
    // MARK: Authentication
    
    // Creates an account with email
    func createUser(withEmail email: String, password: String, completion: @escaping (User?, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password, completion: completion)
    }
    
    // Logs user in with email
    func loginUser(withEmail email: String, password: String, completion: @escaping(User?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    // MARK: User Database
    
    // Add authenticated user to the database
    func addUserToDB(uid: String, name: String, email: String) {
        let timestamp = Int(Date().timeIntervalSince1970)
        let userRef = reference.child("users").child(uid)
        let userData: [String:Any] = ["email": email,
                                      "name": name,
                                      "timestamp": timestamp]
        userRef.setValue(userData)
        print("Successfully added user to Database")
        // TODO: Error Handling if it doesn't work
    }
    
    // Signs user out
    func signOutUser(completion: @escaping(Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true)
        } catch {
            completion(false)
        }
    }
    
    // Email is sent to reset password
    func resetPasswordWithEmail(email: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email, completion: completion)
    }
    
    func handle(error: Error) {
        let nsError = error as NSError
        if let errorCode = AuthErrorCode(rawValue: nsError.code) {
            switch errorCode {
            case .emailAlreadyInUse:
                print("Email in use already.")
            case .invalidEmail:
                print("Email is invalid.")
            case .weakPassword:
                print("Password too weak \(nsError.userInfo["NSLocalizedFailureReasonErrorKey"]!)")
            case .wrongPassword:
                print("Wrong password")
            case .tooManyRequests:
                print("Too many request. Timed out.")
            case .userNotFound:
                print("User not found.")
            default:
                print("Some error.")
            }
        }
    }
    
}
