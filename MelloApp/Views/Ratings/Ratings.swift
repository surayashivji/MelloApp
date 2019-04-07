//
//  Ratings.swift
//  MelloApp
//
//  Created by Suraya Shivji on 27/03/2019.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//


enum Ratings {
    case smellRatings(SmellRatings)
    case blendEffectRatings(BlendEffectRatings)
    case wouldUseAgainRatings(WouldUseAgainRatings)
    
    
    enum SmellRatings {
        case unrated
        case terrible
        case notSure
        case enjoyable
        case amazing
    }
    
    enum BlendEffectRatings {
        case unrated
        case notEffective
        case notSure
        case feelingRefreshed
    }
    
    enum WouldUseAgainRatings {
        case unrated
        case no
        case notSure
        case yes
    }
}
