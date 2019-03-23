//
//  FirebaseManager.swift
//  MelloApp
//
//  Created by Suraya Shivji on 2/8/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON

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
        // TODO: Error Handling if setting value in Firebase doesn't work
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
    
    // MARK: Query User Profile
    
    // Get user's history of blends
    // @return list of dictionaries of blend history
    func getUserBlendHistory(completion: @escaping ([[String:String]]) -> Void) {
        var blendHistory = [[String:String]]()
        if signedIn {
            let userID = user?.uid
            reference.child("users").child(userID!).observeSingleEvent(of: .value) { (snapshot) in
                let value = snapshot.value as? NSDictionary
                if let history = value?["history"] as? NSDictionary {
                    for item in history {
                        let json = JSON(item.value)
                        let blendID: String = json["blend_ID"].stringValue
                        let startTime: String = json["startime"].stringValue
                        let endTime: String = json["endtime"].stringValue
                        // let timestamp = json["timestamp"].doubleValue
                        // let date = Date(timeIntervalSince1970: timestamp/1000)
                        
                        let dict : [String:String] = [
                            "blendID" : blendID,
                            "startTime" : startTime,
                            "endTime" : endTime
                        ]
                        blendHistory.append(dict)
                    }
                    completion(blendHistory)
                }
            }
        }
    }
}
