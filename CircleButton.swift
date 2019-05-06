//
//  CircleButton.swift
//  MelloApp
//
//  Created by Harrison Weinerman on 5/5/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

class CircleButton: UIButton {

    var isOptionHighlighted = false {
        didSet {
            style(isHighlighted: isOptionHighlighted)
        }
    }
    
    var date: Date?

    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        sharedInit()
    }
    
    func sharedInit() {
        layer.cornerRadius = frame.size.width / 2
        layer.masksToBounds = true
        style(isHighlighted: isOptionHighlighted)
        titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
    }
    
    private func style(isHighlighted: Bool) {
        UIView.animate(withDuration: 0.1) {
            self.backgroundColor = isHighlighted ? .darkPurple : .clear
            self.setTitleColor(isHighlighted ? .white : .darkPurple, for: .normal)
        }
    }

}
