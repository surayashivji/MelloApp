//
//  PreferenceButton.swift
//  MelloApp
//
//  Created by Suraya Shivji on 28/03/2019.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

enum PreferenceIndexPath {
    case indexPath(row: Int, section: Int, item: Int)
}

class PreferenceButton: UIControl {
    
    public var isOn = false {
        didSet {
            setupUI()
            layoutSubviews()
        }
    }
    
    var itemIndex: Int = -1
    var diffuseTimereference: Preferences.DiffuseTime?
    

    
    public var buttonIndexPath: PreferenceIndexPath = PreferenceIndexPath.indexPath(row: 0, section: 0, item: 0)
    public var actualIndexPath: IndexPath?
    
    public var text: String? {
        didSet {
            setupUI()
            layoutSubviews()
        }
    }
    
    var titleLabel = UILabel()
    
    public var animationDuration: Double = 0.5
    
    
    fileprivate var isAnimating = false
    
    private func clear() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
    
    func setupUI() {
        self.clear()
        self.clipsToBounds = false
        self.titleLabel.textColor = self.isOn ? #colorLiteral(red: 0.1411764706, green: 0.1411764706, blue: 0.2784313725, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.titleLabel.backgroundColor = !self.isOn ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.1411764706, green: 0.1411764706, blue: 0.2784313725, alpha: 1)
        titleLabel.text = text
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        let centerPoint = CGPoint(x: 0, y: 0)
        titleLabel.frame = CGRect(origin: centerPoint, size: CGSize(width: self.bounds.size.width, height: self.bounds.size.height))
        self.addSubview(titleLabel)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        if !self.isAnimating {
            self.titleLabel.textColor = self.isOn ? #colorLiteral(red: 0.1411764706, green: 0.1411764706, blue: 0.2784313725, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.titleLabel.backgroundColor = self.isOn ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.1411764706, green: 0.1411764706, blue: 0.2784313725, alpha: 1)
        }
        
    }
    
    private func animate() {
        self.isOn = !self.isOn
        self.isAnimating = true
        UIView.animate(withDuration: self.animationDuration, delay: 0, usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.5, options: [UIViewAnimationOptions.curveEaseOut,
                                                             UIViewAnimationOptions.beginFromCurrentState], animations: {
                                                                self.titleLabel.textColor = self.isOn ? #colorLiteral(red: 0.1411764706, green: 0.1411764706, blue: 0.2784313725, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                                                                self.titleLabel.backgroundColor = self.isOn ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.1411764706, green: 0.1411764706, blue: 0.2784313725, alpha: 1)
        }, completion: { _ in
            self.isAnimating = false
            self.sendActions(for: UIControlEvents.valueChanged)
        })
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.beginTracking(touch, with: event)
        self.animate()
        return true
    }
}

