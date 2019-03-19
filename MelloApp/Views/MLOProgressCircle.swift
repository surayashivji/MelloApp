//
//  MLOProgressCircle.swift
//  MelloApp
//
//  Created by Harrison Weinerman on 3/10/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

// adapted from https://codeburst.io/circular-progress-bar-in-ios-d06629700334
class MLOProgressCircle: UIView {
    
    //MARK: awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    
    //MARK: Public
    public var lineWidth: CGFloat = 1 {
        didSet{
            foregroundLayer.lineWidth = lineWidth
            backgroundLayer.lineWidth = lineWidth - (0.20 * lineWidth)
        }
    }
    
    var progress = 0.0
    
    public func setProgress(to progressConstant: Double, withAnimation: Bool) {
        let oldProgress = self.progress
        self.progress = progressConstant
        var progress: Double {
            get {
                if progressConstant > 1 { return 1 }
                else if progressConstant < 0 { return 0 }
                else { return progressConstant }
            }
        }
        
        foregroundLayer.strokeEnd = CGFloat(progress)
        
        if withAnimation {
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = oldProgress
            animation.toValue = progress
            animation.duration = 2
            foregroundLayer.add(animation, forKey: "foregroundAnimation")
            
        }
        
        var currentTime:Double = 0
        let timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { (timer) in
            if currentTime >= 2{
                timer.invalidate()
            } else {
                currentTime += 0.05
            }
        }
        timer.fire()
    }
    
    //MARK: Private
    private let foregroundLayer = CAShapeLayer()
    private let backgroundLayer = CAShapeLayer()
    private var radius: CGFloat {
        get {
            if self.frame.width < self.frame.height { return (self.frame.width - lineWidth) / 2 }
            else { return (self.frame.height - lineWidth) / 2 }
        }
    }
    
    private var pathCenter: CGPoint{ get { return self.convert(self.center, from: self.superview) } }
    private func makeBar(){
        self.layer.sublayers = nil
        drawBackgroundLayer()
        drawForegroundLayer()
    }
    
    private func drawBackgroundLayer(){
        let path = UIBezierPath(arcCenter: pathCenter, radius: self.radius, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        self.backgroundLayer.path = path.cgPath
        self.backgroundLayer.strokeColor = UIColor.blueGray.cgColor
        self.backgroundLayer.lineWidth = lineWidth - (lineWidth * 20 / 100)
        self.backgroundLayer.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(backgroundLayer)
        
    }
    
    private func drawForegroundLayer(){
        
        let startAngle = (-CGFloat.pi/2)
        let endAngle = 2 * CGFloat.pi + startAngle
        
        let path = UIBezierPath(arcCenter: pathCenter, radius: self.radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        foregroundLayer.lineCap = kCALineCapRound
        foregroundLayer.path = path.cgPath
        foregroundLayer.lineWidth = lineWidth
        foregroundLayer.fillColor = UIColor.clear.cgColor
        foregroundLayer.strokeColor = UIColor.white.cgColor
        foregroundLayer.strokeEnd = 0
        
        self.layer.addSublayer(foregroundLayer)
        
    }
    
    private func setupView() {
        makeBar()
        backgroundColor = .clear
    }
    
    //Layout Sublayers
    private var layoutDone = false
    override func layoutSublayers(of layer: CALayer) {
        if !layoutDone {
            setupView()
            layoutDone = true
        }
    }
    
}

////import UIKit
///// Returns a hollow circle with a stroke showing progress up to the given percentage
//class MLOProgressCircle: UIView {
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        sharedInit()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        sharedInit()
//    }
//
//    private let circleShape = CAShapeLayer()
//
//    var progress: CGFloat = 0 {
//        didSet {
//            circleShape.strokeEnd = progress
//        }
//    }
//
//    private func sharedInit() {
////        let roundView = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
////        roundView.backgroundColor = .darkPurple
//////        roundView.layer.cornerRadius = roundView.frame.size.width / 2
////        addSubview(roundView)
////
////        addConstraints([
////            NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: roundView, attribute: .leading, multiplier: 1, constant: 0),
////
////            NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: roundView, attribute: .trailing, multiplier: 1, constant: 0),
////
////            NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: roundView, attribute: .top, multiplier: 1, constant: 0),
////
////            NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: roundView, attribute: .bottom, multiplier: 1, constant: 0)])
////        layoutIfNeeded()
////
////        let circlePath = UIBezierPath(arcCenter: CGPoint (x: roundView.center.x, y: roundView.center.y),
////                                      radius: roundView.frame.size.width / 2,
////                                      startAngle: CGFloat(-0.5 * Float.pi),
////                                      endAngle: CGFloat(1.5 * Float.pi),
////                                      clockwise: true)
////
////
////        circleShape.path = circlePath.cgPath
////        circleShape.strokeColor = UIColor.white.cgColor
////        circleShape.fillColor = UIColor.white.cgColor
////        circleShape.lineWidth = 1.5
////        circleShape.strokeStart = 0.0
////        circleShape.strokeEnd = 0.7
////        roundView.layer.addSublayer(circleShape)
//    }
//
//}
