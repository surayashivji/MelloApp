//
//  MLOProgressCircle.swift
//  MelloApp
//
//  Created by Harrison Weinerman on 3/10/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit
/// Returns a hollow circle with a stroke showing progress up to the given percentage
class MLOProgressCircle: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    private let circleShape = CAShapeLayer()
    
    var progress: CGFloat = 0 {
        didSet {
            circleShape.strokeEnd = progress
        }
    }
    
    private func sharedInit() {
//        let roundView = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
//        roundView.backgroundColor = .darkPurple
////        roundView.layer.cornerRadius = roundView.frame.size.width / 2
//        addSubview(roundView)
//    
//        addConstraints([
//            NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: roundView, attribute: .leading, multiplier: 1, constant: 0),
//            
//            NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: roundView, attribute: .trailing, multiplier: 1, constant: 0),
//            
//            NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: roundView, attribute: .top, multiplier: 1, constant: 0),
//            
//            NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: roundView, attribute: .bottom, multiplier: 1, constant: 0)])
//        layoutIfNeeded()
//        
//        let circlePath = UIBezierPath(arcCenter: CGPoint (x: roundView.center.x, y: roundView.center.y),
//                                      radius: roundView.frame.size.width / 2,
//                                      startAngle: CGFloat(-0.5 * Float.pi),
//                                      endAngle: CGFloat(1.5 * Float.pi),
//                                      clockwise: true)
//        
//        
//        circleShape.path = circlePath.cgPath
//        circleShape.strokeColor = UIColor.white.cgColor
//        circleShape.fillColor = UIColor.white.cgColor
//        circleShape.lineWidth = 1.5
//        circleShape.strokeStart = 0.0
//        circleShape.strokeEnd = 0.7
//        roundView.layer.addSublayer(circleShape)
    }
    
}
