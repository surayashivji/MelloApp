//
//  UserScentManager.swift
//  MelloApp
//
//  Created by Harrison Weinerman on 3/26/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import Foundation

struct ScentBlend {
    static let citrus = ScentBlend(name: "Balance Out Citrus",
                                   ingredients: ["lavender", "lavender", "lavender"],
                                   image: #imageLiteral(resourceName: "smallCitrus"),
                                   color: .brightPink,
                                   isFavorite: true,
                                   id: 0,
                                   description: "des 1")
    
    static let floral = ScentBlend(name: "Focus Floral",
                                   ingredients: ["ginger", "ginger", "ginger"],
                                   image: #imageLiteral(resourceName: "smallFloral"),
                                   color: .brightGreen,
                                   isFavorite: true,
                                   id: 0,
                                   description: "des 2")
    
    static let green = ScentBlend(name: "Sleepy Green",
                                   ingredients: ["lavender", "cinnamon", "peppermint"],
                                   image: #imageLiteral(resourceName: "smallGreen"),
                                   color: .brightPurple,
                                   isFavorite: false,
                                   id: 0,
                                   description: "des3")

    
    var name: String
    var ingredients: [String]
    var image: UIImage
    var color: UIColor
    var isFavorite: Bool?
    var id: Int
    var description: String
}

struct ScheduledBlend {
    var start: Date
    var end: Date
    var scent: ScentBlend
}

class UserScentManager {
    
    let manager = FirebaseManager()
    
    static func recommendations() -> [ScentBlend] {
        return FirebaseManager.instance.userRecommendations
        //return [ScentBlend.citrus, ScentBlend.floral, ScentBlend.green]
    }
    
    static func energyblends() -> [ScentBlend] {
        return [ScentBlend.citrus, ScentBlend.citrus, ScentBlend.citrus]
    }
    
    static func sleepblends() -> [ScentBlend] {
        return [ScentBlend.floral, ScentBlend.floral, ScentBlend.floral]
    }
    
    static func relaxblends() -> [ScentBlend] {
        return [ScentBlend.green, ScentBlend.green, ScentBlend.green]
    }
    
    static func favorites() -> [ScentBlend] {
        return [] //[ScentBlend.citrus, ScentBlend.floral]
    }
    
    // TODO: this will eventually take in a blend ID but right now it is placeholder for the dummy content
    static func toggleFavoriteScent(scentAdded: String) {
        // banner presenter present
    }
    
    static func schedule(for day: Date?) -> [ScheduledBlend] {
        return [ScheduledBlend(start: Date(), end: Date(), scent: ScentBlend.citrus)]
    }
}
