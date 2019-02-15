//
//  Date+Conversions.swift
//  MelloApp
//
//  Created by Suraya Shivji on 2/14/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

extension Date {
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
    }
}

// Date().millisecondsSince1970 // 1476889390939
// Date(milliseconds: 0) // "Dec 31, 1969, 4:00 PM" (PDT variant of 1970 UTC)

