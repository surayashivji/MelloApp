//
//  FaceToggle.swift
//  MelloApp
//
//  Created by Suraya Shivji on 27/03/2019.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

class FaceToggleView: UIView {
    let kCONTENT_XIB_NAME = "FaceToggle"
    
    @IBOutlet var contentView: UIView!
    public var imageForSelect: UIImage? {
        didSet {
            faceToggle.imageForSelect = imageForSelect
        }
    }
    public var imageForDeselect: UIImage? {
        didSet {
            faceToggle.imageForDeselect = imageForDeselect
        }
    }
    
    var faceToggle:FaceToggle = FaceToggle(frame: CGRect.zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        faceToggle = FaceToggle(frame: self.frame)
        faceToggle.imageForSelect = imageForSelect
        faceToggle.imageForDeselect = imageForDeselect
        faceToggle.setupUI()
        commonInit()
    }
    
    func commonInit() {
        faceToggle.translatesAutoresizingMaskIntoConstraints = false
        

        
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        
        contentView.addSubview(faceToggle)
        addConstraint(NSLayoutConstraint(item: contentView, attribute: .bottom, relatedBy: .equal, toItem: faceToggle, attribute: .bottom, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: contentView, attribute: .top, relatedBy: .equal, toItem: faceToggle, attribute: .top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: contentView, attribute: .leading, relatedBy: .equal, toItem: faceToggle, attribute: .leading, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: contentView, attribute: .trailing, relatedBy: .equal, toItem: faceToggle, attribute: .trailing, multiplier: 1, constant: 0))
        contentView.fixInView(self)
    }
    
}

extension UIView
{
    func fixInView(_ container: UIView!) -> Void{
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.frame = container.frame;
        container.addSubview(self);
        
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
}
