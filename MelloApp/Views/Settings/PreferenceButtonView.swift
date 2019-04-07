//
//  PreferenceButtonView.swift
//  MelloApp
//
//  Created by Suraya Shivji on 28/03/2019.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//


import UIKit

class PreferenceButtonView: UIView {
    let kCONTENT_XIB_NAME = "PreferenceButton"
    
    @IBOutlet var contentView: UIView!
    
    var text: String? {
        didSet {
            preferenceButton.text = text
        }
    }
    
    var preferenceButton:PreferenceButton = PreferenceButton(frame: CGRect.zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        preferenceButton = PreferenceButton(frame: self.frame)
        preferenceButton.setupUI()
        commonInit()
    }
    
    func commonInit() {
        preferenceButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        
        contentView.addSubview(preferenceButton)
        addConstraint(NSLayoutConstraint(item: contentView, attribute: .bottom, relatedBy: .equal, toItem: preferenceButton, attribute: .bottom, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: contentView, attribute: .top, relatedBy: .equal, toItem: preferenceButton, attribute: .top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: contentView, attribute: .leading, relatedBy: .equal, toItem: preferenceButton, attribute: .leading, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: contentView, attribute: .trailing, relatedBy: .equal, toItem: preferenceButton, attribute: .trailing, multiplier: 1, constant: 0))
        contentView.fixInView(self)
    }
    
}
