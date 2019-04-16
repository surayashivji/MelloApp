//
//  MLOSelectableOption.swift
//  MelloApp
//
//  Created by Harrison Weinerman on 2/25/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

struct MLOSelectableListOption {
    var title: String
    var defaultColor: UIColor
    var selectionColor: UIColor
    var defaultImage: UIImage?
    var selectionImage: UIImage?
    var selectionTextColor: UIColor
    
    init(title: String,
         defaultColor: UIColor,
         selectionColor: UIColor,
         defaultImage: UIImage? = nil,
         selectionImage: UIImage? = #imageLiteral(resourceName: "checkmark"),
         selectionTextColor: UIColor = .white) {
        self.title = title
        self.defaultColor = defaultColor
        self.selectionColor = selectionColor
        self.defaultImage = defaultImage
        self.selectionImage = selectionImage
        self.selectionTextColor = selectionTextColor
    }
}

enum MLOOnboardingOptionInputType {
    case list, grid
}

enum MLOSelectableOptionType: String {
    case timeOfDay, goal, mindfulness, scents
    
    static var allOptions: [MLOSelectableOptionType] = [.timeOfDay, .goal, .mindfulness, .scents]
    
    var nextOption: MLOSelectableOptionType? {
        switch self {
        case .timeOfDay:
            return .goal
        case .goal:
            return .mindfulness
        case .mindfulness:
            return .scents
        case .scents:
            return nil
        }
    }
    
    var displayType: MLOOnboardingOptionInputType {
        switch self {
        case .timeOfDay:
            return .list
        case .goal:
            return .list
        case .mindfulness:
            return .list
        case .scents:
            return .grid
        }
    }
    
    var title: String {
        switch self {
        case .timeOfDay:
            return "\("User"), what times of the day would you like to diffuse?" // TODO: add name
        case .goal:
            return "How would you like to feel when you wake up?"
        case .mindfulness:
            return "How do you practice mindfulness at home?"
        case .scents:
            return "What kinds of aromatic scents do you enjoy?"
        }
    }
    
    var subtitle: String {
        switch self {
        case .timeOfDay:
            return "Pro Tip: Diffuse 3 times a day for most benefit."
        case .goal:
            return "Start your day feeling excited!"
        case .mindfulness:
            return "This will allow us to enhance your activities with complimentary blends :)"
        case .scents:
            return "We'll help you feel good and smell good!"
        }
    }
    
    var options: [MLOSelectableListOption] {
        switch self {
        case .timeOfDay:
            return [MLOSelectableListOption(title: "When I wake up",
                                            defaultColor: .mediumPurple,
                                            selectionColor: .lightBlue,
                                            selectionImage: #imageLiteral(resourceName: "checkmarkDark"),
                                            selectionTextColor: .darkPurple),
                    MLOSelectableListOption(title: "During the day",
                                            defaultColor: .mediumPurple,
                                            selectionColor: .lightBlue,
                                            selectionImage: #imageLiteral(resourceName: "checkmarkDark"),
                                            selectionTextColor: .darkPurple),
                    MLOSelectableListOption(title: "Before bed",
                                            defaultColor: .mediumPurple,
                                            selectionColor: .lightBlue,
                                            selectionImage: #imageLiteral(resourceName: "checkmarkDark"),
                                            selectionTextColor: .darkPurple)]
        case .goal:
            return [MLOSelectableListOption(title: "Focused",
                                            defaultColor: .mediumPurple,
                                            selectionColor: .brightGreen),
                    MLOSelectableListOption(title: "Relaxed",
                                            defaultColor: .mediumPurple,
                                            selectionColor: .brightPurple),
                    MLOSelectableListOption(title: "Balanced",
                                            defaultColor: .mediumPurple,
                                            selectionColor: .brightPink),
                    MLOSelectableListOption(title: "Energized",
                                            defaultColor: .mediumPurple,
                                            selectionColor: .orange)]
        case .mindfulness:
            return [MLOSelectableListOption(title: "Sleep",
                                            defaultColor: .mediumPurple,
                                            selectionColor: .white,
                                            selectionImage: #imageLiteral(resourceName: "checkmarkDark"),
                                            selectionTextColor: .darkPurple),
                    MLOSelectableListOption(title: "Meditation",
                                            defaultColor: .mediumPurple,
                                            selectionColor: .white,
                                            selectionImage: #imageLiteral(resourceName: "checkmarkDark"),
                                            selectionTextColor: .darkPurple),
                    MLOSelectableListOption(title: "Work-out",
                                            defaultColor: .mediumPurple,
                                            selectionColor: .white,
                                            selectionImage: #imageLiteral(resourceName: "checkmarkDark"),
                                            selectionTextColor: .darkPurple),
                    MLOSelectableListOption(title: "Socialize",
                                            defaultColor: .mediumPurple,
                                            selectionColor: .white,
                                            selectionImage: #imageLiteral(resourceName: "checkmarkDark"),
                                            selectionTextColor: .darkPurple),
                    MLOSelectableListOption(title: "Listen to music",
                                            defaultColor: .mediumPurple,
                                            selectionColor: .white,
                                            selectionImage: #imageLiteral(resourceName: "checkmarkDark"),
                                            selectionTextColor: .darkPurple),
                    MLOSelectableListOption(title: "None of the above",
                                            defaultColor: .mediumPurple,
                                            selectionColor: .white,
                                            selectionImage: #imageLiteral(resourceName: "checkmarkDark"),
                                            selectionTextColor: .darkPurple)]
        case .scents:
            return [MLOSelectableListOption(title: "Citrus",
                                            defaultColor: .mediumPurple,
                                            selectionColor: .white,
                                            defaultImage: #imageLiteral(resourceName: "citrus"),
                                            selectionImage: #imageLiteral(resourceName: "checkmarkDark"),
                                            selectionTextColor: .darkPurple),
                    MLOSelectableListOption(title: "Floral",
                                            defaultColor: .mediumPurple,
                                            selectionColor: .white,
                                            defaultImage: #imageLiteral(resourceName: "floral"),
                                            selectionImage: #imageLiteral(resourceName: "checkmarkDark"),
                                            selectionTextColor: .darkPurple),
                    MLOSelectableListOption(title: "Green",
                                            defaultColor: .mediumPurple,
                                            selectionColor: .white,
                                            defaultImage: #imageLiteral(resourceName: "green"),
                                            selectionImage: #imageLiteral(resourceName: "checkmarkDark"),
                                            selectionTextColor: .darkPurple),
                    MLOSelectableListOption(title: "Woody",
                                            defaultColor: .mediumPurple,
                                            selectionColor: .white,
                                            defaultImage: #imageLiteral(resourceName: "woody"),
                                            selectionImage: #imageLiteral(resourceName: "checkmarkDark"),
                                            selectionTextColor: .darkPurple)]
        }
    }
}
