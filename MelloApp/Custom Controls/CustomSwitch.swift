//
//  CustomSwitch.swift
//  MelloApp
//
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

class CustomSwitch: UIControl {
    
    public var isOn = true
    
    public var animationDuration: Double = 0.5

    public var padding: CGFloat = 4 {
        didSet {
            self.layoutSubviews()
        }
    }
    public var onTintColor = UIColor.white {
        didSet {
            self.setupUI()
        }
    }
    public var offTintColor = UIColor.white {
        didSet {
            self.setupUI()
        }
    }
    public var cornerRadius: CGFloat = 0.5 {
        didSet {
            self.layoutSubviews()
        }
    }
    public var thumbTintColor: UIColor = #colorLiteral(red: 0.1803921569, green: 0.1921568627, blue: 0.2901960784, alpha: 1)  {
        didSet {
            self.thumbView.backgroundColor = self.thumbTintColor
        }
    }
    public var thumbCornerRadius: CGFloat = 0.5 {
        didSet {
            self.layoutSubviews()
        }
    }
    public var thumbSize = CGSize.zero {
        didSet {
            self.layoutSubviews()
        }
    }
    
    fileprivate var thumbView = UIView(frame: CGRect.zero)
    fileprivate var onLabel = UILabel(frame: CGRect.zero)
    fileprivate var offLabel = UILabel(frame: CGRect.zero)
    
    fileprivate var onPoint = CGPoint.zero
    
    fileprivate var offPoint = CGPoint.zero
    
    fileprivate var isAnimating = false
    
    private func clear() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
    
    func setupUI() {
        self.clear()
        self.clipsToBounds = false
        self.thumbView.backgroundColor = self.thumbTintColor
        self.thumbView.isUserInteractionEnabled = false
        self.thumbView.layer.shadowColor = UIColor.black.cgColor
        self.thumbView.layer.shadowRadius = 1.5
        self.thumbView.layer.shadowOpacity = 0.4
        self.thumbView.layer.shadowOffset = CGSize(width: 0.75, height: 2)
        
        let yPosition = (self.bounds.size.height - 15) / 2
        let onLabelPoint = CGPoint(x: 20, y: yPosition)
        let offLabelPoint = CGPoint(x: self.frame.width - 40, y: yPosition)
        
        onLabel.frame = CGRect(origin: onLabelPoint, size: CGSize(width: 40, height: 15))
        onLabel.text = "On"
        onLabel.textColor = #colorLiteral(red: 0.1803921569, green: 0.1921568627, blue: 0.2901960784, alpha: 1)
        
        offLabel.frame = CGRect(origin: offLabelPoint, size: CGSize(width: 40, height: 15))
        offLabel.text = "Off"
        offLabel.textColor = #colorLiteral(red: 0.1803921569, green: 0.1921568627, blue: 0.2901960784, alpha: 1)
        
        self.addSubview(onLabel)
        self.addSubview(offLabel)
        self.addSubview(self.thumbView)
        
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        if !self.isAnimating {
            self.layer.cornerRadius = self.bounds.size.height * self.cornerRadius
            self.backgroundColor = self.isOn ? self.onTintColor : self.offTintColor
            
            
            // thumb managment
            
            let thumbSize = self.thumbSize != CGSize.zero ? self.thumbSize : CGSize(width:
                self.bounds.size.height - 4, height: self.bounds.size.height - 4)
            let yPosition = (self.bounds.size.height - thumbSize.height) / 2
            
            self.onPoint = CGPoint(x: self.bounds.size.width - thumbSize.width - self.padding, y: yPosition)
            self.offPoint = CGPoint(x: self.padding, y: yPosition)
            
            self.thumbView.frame = CGRect(origin: self.isOn ? self.onPoint : self.offPoint, size: thumbSize)
            
            self.thumbView.layer.cornerRadius = thumbSize.height * self.thumbCornerRadius
            
            self.onLabel.isHidden = !self.isOn
            self.offLabel.isHidden = self.isOn
            
        }
        
    }
    
    private func animate() {
        self.isOn = !self.isOn
        self.isAnimating = true
        UIView.animate(withDuration: self.animationDuration, delay: 0, usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.5, options: [UIViewAnimationOptions.curveEaseOut,
                                                             UIViewAnimationOptions.beginFromCurrentState], animations: {
                                                                self.thumbView.frame.origin.x = self.isOn ? self.onPoint.x : self.offPoint.x
                                                                self.backgroundColor = self.isOn ? self.onTintColor : self.offTintColor
                                                                self.onLabel.isHidden = !self.isOn
                                                                self.offLabel.isHidden = self.isOn
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
