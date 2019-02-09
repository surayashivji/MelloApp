//
//  ColorPalette.swift
//  MelloApp
//
//  Created by Suraya Shivji on 2/4/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

struct ColorPalette {
    static let white = UIColor.fromRGB(r: 255, g: 255, b: 255)
    static let black = UIColor.fromRGB(r: 0, g: 0, b: 0)
    static let lilac = UIColor.fromRGB(r: 228, g: 236, b: 255)
    static let muted = UIColor.fromRGB(r: 94, g: 97, b: 129)
    static let blue = UIColor.fromRGB(r: 42, g: 116, b: 255)
    static let purple = UIColor.fromRGB(r: 124, g: 2, b: 245)
    static let green = UIColor.fromRGB(r: 12, g: 204, b: 196)
}

// RGB to UIColor
extension UIColor {
    class func fromRGB(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        let color = UIColor.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
        return color
    }
}
