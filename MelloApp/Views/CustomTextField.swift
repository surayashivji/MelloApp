//
//  CustomTextField.swift
//  MelloApp
//
//  Created by Suraya Shivji on 2/5/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        let placeholderString = NSAttributedString(string: self.attributedPlaceholder?.string ?? "",
                                                   attributes: [NSAttributedStringKey.foregroundColor: UIColor.muted])
        self.attributedPlaceholder = placeholderString
    }
}

