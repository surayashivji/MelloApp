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
        // TODO: Error Handling if setting value in Firebase doesn't work
    }
    
    
    // Init new user's stats
    func initUserStats(uid: String) {
        let statsRef = reference.child("users").child(uid).child("stats")
        let statsData: [String:Int] = ["current_streak": 0,
                                       "longest_streak": 0,
                                       "time_diffused": 0,
                                       "total_sessions": 0]
        statsRef.setValue(statsData)
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
    func getUserStats(completion: @escaping ([String:String]?) -> Void) {
        var statsHistory = [String:String]()
        if signedIn {
            guard let userID = user?.uid else {
                completion(nil)
                return
            }
            reference.child("users").child(userID).observeSingleEvent(of: .value) { (snapshot) in
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
    
    // Get user information based on uid
    func getUserInformation(completion: @escaping ([String:Any]?) -> Void) {
        var userInfo = [String:Any]()
        if signedIn {
            guard let userID = user?.uid else {
                completion(nil)
                return
            }
            reference.child("users").child(userID).observeSingleEvent(of: .value) { (snapshot) in
                let value = snapshot.value as? NSDictionary
                if let email = value?["email"],
                    let name = value?["name"] {
                    let dict = ["email" : email,
                                "name" : name]
                    userInfo = dict
                    completion(userInfo)
                }
            }
        }
    }
    
    // Get user's history of blends
    func getUserBlendHistory(completion: @escaping ([[String:Any]]?) -> Void) {
        var blendHistory = [[String:Any]]()
        if signedIn {
            guard let userID = user?.uid else {
                completion(nil)
                return
            }
            reference.child("users").child(userID).observeSingleEvent(of: .value) { (snapshot) in
                let value = snapshot.value as? NSDictionary
                if let history = value?["history"] as? NSDictionary {
                    for item in history {
                        let json = JSON(item.value)
                        let blendID: String = json["blend_ID"].stringValue
                        let timestamp = json["timestamp"].doubleValue
                        let dict : [String:Any] = [
                            "blend_ID" : blendID,
                            "timestamp" : timestamp
                        ]
                        blendHistory.append(dict)
                    }
                    completion(blendHistory)
                }
            }
        }
    }
    
    // Get name / aroma / benefit based on blend ID
    func getBlendQualities(blendID: String, completion: @escaping (String, String, String) -> Void) {
        if signedIn {
            reference.child("aromatherapy").child("blends").child(blendID).observeSingleEvent(of: .value) { (snapshot) in
                if let blend = snapshot.value as? NSDictionary {
                    let json = JSON(blend)
                    let name: String = json["general_name"].stringValue
                    let aroma: String = json["aroma"].stringValue
                    let benefit: String = json["benefit"].stringValue
                    completion(name, aroma, benefit)
                }
            }
        }
    }
    
    // MARK: Discover Categories
    
    // Get list of blends for category name
    func getBlendsForCategory(category: String, completion: @escaping ([String]) -> Void) {
        var blends = [String]()
        reference.child("global_recs").child(category).observeSingleEvent(of: .value) { (snapshot) in
            if let categoryBlends = snapshot.value as? [String:String] {
                for blend in categoryBlends {
                    blends.append(blend.value)
                }
                completion(blends)
            }
        }
    }
}

