//
//  FirebaseManager+Errors.swift
//  MelloApp
//
//  Created by Suraya Shivji on 2/9/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit
import Firebase

extension FirebaseManager {
    func handle(error: Error, completion: @escaping (String?, String?) -> Void) {
        let nsError = error as NSError
        var errorStringTitle = ""
        var errorStringInstructions = ""
        if let errorCode = AuthErrorCode(rawValue: nsError.code) {
            switch errorCode {
            case .emailAlreadyInUse:
                errorStringTitle = "Email in use already."
                errorStringInstructions = "This email is in use, please log in!"
            case .invalidEmail:
                errorStringTitle = "Email is invalid."
                errorStringInstructions = "Please enter a valid email address"
            case .weakPassword:
                errorStringTitle = "Password too weak \(nsError.userInfo["NSLocalizedFailureReasonErrorKey"]!)"
                errorStringInstructions = "Your password should have at least 6 characters"
            case .wrongPassword:
                errorStringTitle = "Wrong password"
                errorStringInstructions = "Please enter the correct password."
            case .tooManyRequests:
                errorStringTitle = "Too many request. Timed out."
                errorStringInstructions = "Our servers are overloaded. Please come back in a few minutes!"
            case .userNotFound:
                errorStringTitle = "User not found"
                errorStringInstructions = "We can't find this account. Please sign up!"
            default:
                print("Some other error.")
            }
            completion(errorStringTitle, errorStringInstructions)
        }
    }
}
