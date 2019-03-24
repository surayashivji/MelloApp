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
    
    // Get user's statistics
    func getUserStats(completion: @escaping ([String:String]) -> Void) {
        var statsHistory = [String:String]()
        if signedIn {
            let userID = user?.uid
            reference.child("users").child(userID!).observeSingleEvent(of: .value) { (snapshot) in
                let value = snapshot.value as? NSDictionary
                if let stats = value?["stats"] as? NSDictionary {
                    let json = JSON(stats)
                    let currentStreak: String = json["current_streak"].stringValue
                    let longestStreak: String = json["longest_streak"].stringValue
                    let timeDiffused: String = json["time_diffused"].stringValue
                    let totalSessions = json["total_sessions"].stringValue
                    
                    let dict : [String:String] = [
                        "currentStreak" : currentStreak,
                        "longestStreak" : longestStreak,
                        "timeDiffused" : timeDiffused,
                        "totalSessions" : totalSessions
                    ]
                    statsHistory = dict
                    completion(statsHistory)
                }
            }
        }
    }
    
    // Get user's history of blends
    func getUserBlendHistory(completion: @escaping ([[String:Any]]) -> Void) {
        var blendHistory = [[String:Any]]()
        if signedIn {
            let userID = user?.uid
            reference.child("users").child(userID!).observeSingleEvent(of: .value) { (snapshot) in
                let value = snapshot.value as? NSDictionary
                if let history = value?["history"] as? NSDictionary {
                    for item in history {
                        let json = JSON(item.value)
                        let blendID: String = json["blend_ID"].stringValue
                        let blendName: String = json["blend_NAME"].stringValue
                        let timestamp = json["timestamp"].doubleValue
                        
                        let dict : [String:Any] = [
                            "blend_ID" : blendID,
                            "blend_NAME" : blendName,
                            "timestamp" : timestamp
                        ]
                        blendHistory.append(dict)
                    }
                    completion(blendHistory)
                }
            }
        }
    }
    
    // Get aroma and benefit based on blend ID
    func getBlendQualities(blendID: String, completion: @escaping (String, String) -> Void) {
        if signedIn {
            reference.child("aromatherapy").child("blends").child(blendID).observeSingleEvent(of: .value) { (snapshot) in
                if let blend = snapshot.value as? NSDictionary {
                    let json = JSON(blend)
                    let aroma: String = json["aroma"].stringValue
                    let benefit: String = json["benefit"].stringValue
                    completion(aroma, benefit)
                }
            }
        }
    }
}
