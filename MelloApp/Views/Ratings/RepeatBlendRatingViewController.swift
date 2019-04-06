//
//  RepeatBlendRatingViewController.swift
//  MelloApp
//
//  Created by Suraya Shivji on 26/03/2019.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

class RepeatBlendRatingViewController: UIViewController {

    @IBOutlet weak var noFaceView: FaceToggleView!
    @IBOutlet weak var notSureFaceView: FaceToggleView!
    @IBOutlet weak var yesFaceView: FaceToggleView!
    
    var selectedFace: FaceToggle?
    var ratingsVCDelegate: RatingsViewControllerDelegate?
    var indexInPageVC: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        noFaceView.imageForSelect = UIImage(named: "noWhite")
        noFaceView.imageForDeselect = UIImage(named: "noBlack")
        noFaceView.faceToggle.tag = 1
        noFaceView.faceToggle.addTarget(self, action: #selector(faceTapped), for: .valueChanged)
        
        notSureFaceView.imageForSelect = UIImage(named: "notSureQMarkWhite")
        notSureFaceView.imageForDeselect = UIImage(named: "notSureQMarkBlack")
        notSureFaceView.faceToggle.tag = 2
        notSureFaceView.faceToggle.addTarget(self, action: #selector(faceTapped), for: .valueChanged)
        
        yesFaceView.imageForSelect = UIImage(named: "yesExclamationWhite")
        yesFaceView.imageForDeselect = UIImage(named: "yesExclamationBlack")
        yesFaceView.faceToggle.tag = 3
        yesFaceView.faceToggle.addTarget(self, action: #selector(faceTapped), for: .valueChanged)
    }
    
    @objc
    func faceTapped(sender: FaceToggle) {
        if(sender != selectedFace) {
            selectedFace?.isOn = false
            selectedFace = sender
        }
        
        switch sender.tag {
        case 1: ratingsVCDelegate?.setRatingsFor(rating: .wouldUseAgainRatings(.no), indexOfPageVC: indexInPageVC)
        case 2:
            ratingsVCDelegate?.setRatingsFor(rating: .wouldUseAgainRatings(.notSure), indexOfPageVC: indexInPageVC)
        case 3:
            ratingsVCDelegate?.setRatingsFor(rating: .wouldUseAgainRatings(.yes), indexOfPageVC: indexInPageVC)
        default: print("Rating...")
        }
    }
}

