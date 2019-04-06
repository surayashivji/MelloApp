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
                                   ingredients: "orange, lavendar, mint",
                                   image: #imageLiteral(resourceName: "smallCitrus"), color: .brightPink,
                                   isFavorite: true)
    static let floral = ScentBlend(name: "Focus Floral",
                                   ingredients: "peppermint, majoram",
                                   image: #imageLiteral(resourceName: "smallFloral"), color: .brightGreen,
                                   isFavorite: true)
    static let green = ScentBlend(name: "Sleepy Green",
                                   ingredients: "lavender, cinnamon, peppermint",
                                   image: #imageLiteral(resourceName: "smallGreen"),
                                   color: .brightPurple,
                                   isFavorite: false)
    
    var name: String
    var ingredients: String
    var image: UIImage
    var color: UIColor
    var isFavorite: Bool?
}

struct ScheduledBlend {
    var start: Date
    var end: Date
    var scent: ScentBlend
}

class UserScentManager {
    static func recommendations() -> [ScentBlend] {
        return [ScentBlend.citrus, ScentBlend.floral, ScentBlend.green]
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
