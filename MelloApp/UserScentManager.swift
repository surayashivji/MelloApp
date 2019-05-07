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
                                   id: 16,
                                   description: "des 1")
    
    static let floral = ScentBlend(name: "Focus Floral",
                                   ingredients: ["ginger", "ginger", "ginger"],
                                   image: #imageLiteral(resourceName: "smallFloral"),
                                   color: .brightGreen,
                                   isFavorite: true,
                                   id: 15,
                                   description: "des 2")
    
    static let green = ScentBlend(name: "Sleepy Green",
                                  ingredients: ["lavender", "cinnamon", "peppermint"],
                                  image: #imageLiteral(resourceName: "smallGreen"),
                                  color: .brightPurple,
                                  isFavorite: false,
                                  id: 13,
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
    var datePath: String?
    var scentId: Int
    var scentName: String
    var scentImage: UIImage
    var scheduleId: String
    var isSingularEvent: Bool
    var dayOfWeek: Int?
}

class UserScentManager {
    
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
        var schedule = [ScheduledBlend]()
        
        let dayOfWeekFormatter = DateFormatter()
        dayOfWeekFormatter.dateFormat = "e"
        dayOfWeekFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        
        if let repeating = FirebaseManager.instance.repeatingSchedule,
            let day = day,
            let dayOfWeek = Int(dayOfWeekFormatter.string(from: day)),
            let repeatingValues = repeating["d\(dayOfWeek)"] as? NSDictionary,
            let daily = repeatingValues.allValues as? [NSDictionary],
            let scheduleIds = repeatingValues.allKeys as? [String] {
            for (index, item) in daily.enumerated() {
                guard let blendId = item["blend"] as? String,
                    let blendDictionary = FirebaseManager.instance.blends[blendId] as? NSDictionary,
                    let blendName = blendDictionary["general_name"] as? String,
                    let aroma = blendDictionary["aroma"] as? String,
                    let benefit = blendDictionary["benefit"] as? String,
                    let image = UIImage(named: aroma + benefit),
                    let startTimeString = item["time"] as? String,
                    let startTime = timeFormatter.date(from: startTimeString),
                    let durationString = item["duration"] as? String,
                    let duration = Int(durationString),
                    let endTime = Calendar.current.date(byAdding: .minute, value: duration, to: startTime) else {
                        continue
                }
                schedule.append(ScheduledBlend(start: startTime,
                                               end: endTime,
                                               datePath: nil,
                                               scentId: Int(blendId) ?? 0,
                                               scentName: blendName,
                                               scentImage: image,
                                               scheduleId: scheduleIds[index],
                                               isSingularEvent: false,
                                               dayOfWeek: dayOfWeek))
            }
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let singular = FirebaseManager.instance.singularSchedule,
            let day = day,
            let scheduled = singular[dateFormatter.string(from: day)] as? NSDictionary,
            let scheduledBlendIds = scheduled.allKeys as? [String],
            let scheduledBlends = scheduled.allValues as? [NSDictionary] {
            
            for (index, item) in scheduledBlends.enumerated() {
                guard let blendId = item["blend"] as? String,
                    let blendDictionary = FirebaseManager.instance.blends[blendId] as? NSDictionary,
                    let blendName = blendDictionary["general_name"] as? String,
                    let aroma = blendDictionary["aroma"] as? String,
                    let benefit = blendDictionary["benefit"] as? String,
                    let image = UIImage(named: aroma + benefit),
                    let startTimeString = item["time"] as? String,
                    let startTime = timeFormatter.date(from: startTimeString),
                    let durationString = item["duration"] as? String,
                    let duration = Int(durationString),
                    let endTime = Calendar.current.date(byAdding: .minute, value: duration, to: startTime) else {
                        continue
                }
                schedule.append(ScheduledBlend(start: startTime,
                                               end: endTime,
                                               datePath: dateFormatter.string(from: day),
                                               scentId: Int(blendId) ?? 0,
                                               scentName: blendName,
                                               scentImage: image,
                                               scheduleId: scheduledBlendIds[index],
                                               isSingularEvent: true,
                                               dayOfWeek: nil))
            }
            
            
        }
        
        return schedule.sorted(by: { $0.start < $1.start })
    }
}
