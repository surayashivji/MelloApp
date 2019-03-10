//
//  ColorPalette.swift
//  MelloApp
//
//  Created by Suraya Shivji on 2/4/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

extension UIColor {
    static let white = UIColor.fromRGB(r: 255, g: 255, b: 255)
    static let black = UIColor.fromRGB(r: 0, g: 0, b: 0)
    static let lilac = UIColor.fromRGB(r: 228, g: 236, b: 255)
    static let muted = UIColor.fromRGB(r: 94, g: 97, b: 129)
    static let blue = UIColor.fromRGB(r: 42, g: 116, b: 255)
    static let purple = UIColor.fromRGB(r: 124, g: 2, b: 245)
    static let green = UIColor.fromRGB(r: 12, g: 204, b: 196)
    
    static let lightBlue = UIColor(red: 0.89, green: 0.93, blue: 1, alpha: 1)
    static let darkPurple = UIColor(red: 0.09, green: 0.09, blue: 0.2, alpha: 1)
    static let mediumPurple = UIColor(red: 0.14, green: 0.14, blue: 0.28, alpha: 1)
    static let brightPurple = UIColor(red: 0.34, green: 0.3, blue: 0.85, alpha: 1)
    static let brightGreen = UIColor(red: 0.55, green: 0.77, blue: 0.09, alpha: 1)
    static let brightPink = UIColor(red: 0.85, green: 0.3, blue: 0.5, alpha: 1)
    static let orange = UIColor.fromRGB(r: 236, g: 163, b: 55)
}

// RGB to UIColor
extension UIColor {
    class func fromRGB(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        let color = UIColor.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
        return color
    }
}
