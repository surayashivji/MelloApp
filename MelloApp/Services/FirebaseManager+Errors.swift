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
