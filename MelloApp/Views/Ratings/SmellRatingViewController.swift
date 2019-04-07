//
//  SmellRatingViewController.swift
//  MelloApp
//
//  Created by Suraya Shivji on 26/03/2019.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

class SmellRatingViewController: UIViewController {
    @IBOutlet weak var terribleView: FaceToggleView!
    @IBOutlet weak var notSureFaceView: FaceToggleView!
    @IBOutlet weak var enjoyableFaceView: FaceToggleView!
    @IBOutlet weak var amazingFaceView: FaceToggleView!
    
    var selectedFace: FaceToggle?
    var ratingsVCDelegate: RatingsViewControllerDelegate?
    var indexInPageVC: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        terribleView.imageForSelect = UIImage(named: "terribleWhite")
        terribleView.imageForDeselect = UIImage(named: "terribleBlack")
        terribleView.faceToggle.tag = 1
        terribleView.faceToggle.addTarget(self, action: #selector(faceTapped), for: .valueChanged)
        
        notSureFaceView.imageForSelect = UIImage(named: "notSureWhite")
        notSureFaceView.imageForDeselect = UIImage(named: "notSureBlack")
        notSureFaceView.faceToggle.tag = 2
        notSureFaceView.faceToggle.addTarget(self, action: #selector(faceTapped), for: .valueChanged)
        
        enjoyableFaceView.imageForSelect = UIImage(named: "enjoyableWhite")
        enjoyableFaceView.imageForDeselect = UIImage(named: "enjoyableBlack")
        enjoyableFaceView.faceToggle.tag = 3
        enjoyableFaceView.faceToggle.addTarget(self, action: #selector(faceTapped), for: .valueChanged)
        
        amazingFaceView.imageForSelect = UIImage(named: "amazingWhite")
        amazingFaceView.imageForDeselect = UIImage(named: "amazingBlack")
        amazingFaceView.faceToggle.tag = 4
        amazingFaceView.faceToggle.addTarget(self, action: #selector(faceTapped), for: .valueChanged)
    }
    
    @objc
    func faceTapped(sender: FaceToggle) {
        if(sender != selectedFace) {
            selectedFace?.isOn = false
            selectedFace = sender
        }
        
        switch sender.tag {
        case 1: ratingsVCDelegate?.setRatingsFor(rating: .smellRatings(.terrible), indexOfPageVC: indexInPageVC)
        case 2:
            ratingsVCDelegate?.setRatingsFor(rating: .smellRatings(.notSure), indexOfPageVC: indexInPageVC)
        case 3:
            ratingsVCDelegate?.setRatingsFor(rating: .smellRatings(.enjoyable), indexOfPageVC: indexInPageVC)
        case 4:
            ratingsVCDelegate?.setRatingsFor(rating: .smellRatings(.amazing), indexOfPageVC: indexInPageVC)
        default: print("Rating...")
        }
    }
}

