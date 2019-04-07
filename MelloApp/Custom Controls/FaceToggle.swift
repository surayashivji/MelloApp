//
//  FaceToggle.swift
//  MelloApp
//
//  Created by Suraya Shivji on 26/03/2019.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

class FaceToggle: UIControl {
    
    public var isOn = false {
        didSet {
            setupUI()
            layoutSubviews()
        }
    }
    public var imageForSelect: UIImage? {
        didSet {
            selectedImageView = UIImageView(image: imageForSelect, highlightedImage: imageForDeselect)
            setupUI()
            layoutSubviews()
        }
    }
    public var imageForDeselect: UIImage? {
        didSet {
            selectedImageView = UIImageView(image: imageForSelect, highlightedImage: imageForDeselect)
            setupUI()
            layoutSubviews()
        }
    }
    
    var selectedImageView = UIImageView()
    
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
        backgroundColor = .red
        selectedImageView = UIImageView(image: imageForSelect, highlightedImage: imageForDeselect)
        selectedImageView.backgroundColor = .white
        let centerPoint = CGPoint(x: 0, y: 0)
        selectedImageView.frame = CGRect(origin: centerPoint, size: CGSize(width: self.bounds.size.width, height: self.bounds.size.height))
        self.addSubview(selectedImageView)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        if !self.isAnimating {
            self.selectedImageView.isHighlighted = self.isOn
        }
        
    }
    
    private func animate() {
        self.isOn = !self.isOn
        self.isAnimating = true
        UIView.animate(withDuration: self.animationDuration, delay: 0, usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.5, options: [UIViewAnimationOptions.curveEaseOut,
                                                             UIViewAnimationOptions.beginFromCurrentState], animations: {
                                                                self.selectedImageView.isHighlighted = self.isOn
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

