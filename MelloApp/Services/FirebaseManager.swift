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
    
    // MARK: Authenticationl
    
    // Creates an account with email
    func createUser(withEmail email: String, password: String, completion: @escaping (User?, Error?) -> Void) {
        //        Auth.auth().createUser(withEmail: email, password: password, completion: completion)
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            completion(result?.user, error)
        }
        
    }
    
    // Logs user in with email
    func loginUser(withEmail email: String, password: String, completion: @escaping(User?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: { result, error in
            self.loadOils()
            completion(result?.user, error)
        })
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
    
    
    func setUserPreference(data: [String:Any]) {
        var timestampedData = data
        let timestamp = Int(Date().timeIntervalSince1970)
        timestampedData["timestamp"] = timestamp
        guard let uid = user?.uid else { return }
        let userRef = reference.child("users").child(uid).child("preferences")
        userRef.updateChildValues(data)
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
    var oils: NSDictionary = [:]
    func loadOils() {
        reference.child("aromatherapy").child("oils").observe(.value) { (dataSnapshot, string) in
            guard let oils = dataSnapshot.value as? NSDictionary else {
                return
            }
            self.oils = oils
            self.loadBlends()
        }
    }
    
    var blends: NSDictionary = [:]
    func loadBlends() {
        reference.child("aromatherapy").child("blends").observe(.value) { (dataSnapshot, string) in
            guard let blends = dataSnapshot.value as? NSDictionary else {
                return
            }
            self.blends = blends
            self.getUserRecommendations()
        }
    }
    
    var userRecommendations: [ScentBlend] = []
    func getUserRecommendations() {
        guard let uid = user?.uid else { return }
        let userRef = reference.child("users").child(uid).child("recs")
        userRef.observe(.value) { (dataSnapshot, string) in
            guard let blendIds = dataSnapshot.value as? [Int] else {
                return
            }
            
            for id in blendIds {
                let blend = self.blends["\(id)"] as? [String : Any]
                guard let aroma = blend?["aroma"] as? String,
                    let benefit = blend?["benefit"] as? String,
                    let image = UIImage(named: aroma + benefit),
                    let ingredients = ((((blend?["ingredients"] as? Array<Any>)?.compactMap({ $0 as? NSDictionary }))?.compactMap({ $0["oilID"] }) as? [Int])?.compactMap({ self.oils["\($0)"] }) as? Array<NSDictionary>)?.compactMap({ $0["common_name"] }) as? [String] else {
                        continue
                }
                
                self.userRecommendations
                    .append(ScentBlend(name: blend?["general_name"] as? String ?? "",
                                       ingredients: ingredients,
                                       image: image,
                                       color: self.color(from: benefit),
                                       isFavorite: false,
                                       id: id,
                                       description: blend?["description"] as? String ?? ""))
                
            }
            
            NotificationCenter.default.post(name: NSNotification.Name.onFirebaseInit,
                                            object: self)
        }
        
    }
    
    func color(from benefit: String) -> UIColor {
        switch benefit {
        case "Balanced":
            return .brightPink
        case "Energize":
            return .orange
        case "Focus":
            return .brightGreen
        case "Relax":
            return .brightPurple
        default:
            return .mediumPurple
        }
    }
    

    func schedule(blend: ScentBlend?,
                  dates: [Date],
                  time: Date,
                  duration minutes: Int) {
        guard let uid = user?.uid, let blend = blend else { return }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let userRef = reference.child("users").child(uid).child("schedule").child("singular")
        let scheduleID = UUID().uuidString
        for date in dates {
            userRef.child(dateFormatter.string(from: date)).updateChildValues([scheduleID : [
                "blend" : String(blend.id),
                "time" : timeFormatter.string(from: time),
                "duration" : String(minutes)
                ]])
        }
    }
    
    func schedule(blend: ScentBlend?,
                  time: Date,
                  repeats daysOfWeek: [Int],
                  duration minutes: Int) {
        guard let uid = user?.uid, let blend = blend else { return }
        let dayOfWeekFormatter = DateFormatter()
        dayOfWeekFormatter.dateFormat = "E"
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let userRef = reference.child("users").child(uid).child("schedule").child("repeating")
        let scheduleID = UUID().uuidString
        for day in daysOfWeek {
            userRef.child("d\(day)").updateChildValues([scheduleID : [
                "blend" : String(blend.id),
                "time" : timeFormatter.string(from: time),
                "duration" : String(minutes)
                ]])
        }
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


extension Notification.Name {
    static let onFirebaseInit = Notification.Name("onFirebaseInit")
}
