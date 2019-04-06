//
//  EnergizerRatingViewController.swift
//  MelloApp
//
//  Created by Suraya Shivji on 26/03/2019.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

class EnergizerRatingViewController: UIViewController {
    @IBOutlet weak var notEffectiveFaceView: FaceToggleView!
    @IBOutlet weak var feelingRefreshedFaceView: FaceToggleView!
    @IBOutlet weak var notSureFaceView: FaceToggleView!
    
    
    var selectedFace: FaceToggle?
    var ratingsVCDelegate: RatingsViewControllerDelegate?
    var indexInPageVC: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        notEffectiveFaceView.imageForSelect = UIImage(named: "terribleWhite")
        notEffectiveFaceView.imageForDeselect = UIImage(named: "terribleBlack")
        notEffectiveFaceView.faceToggle.tag = 1
        notEffectiveFaceView.faceToggle.addTarget(self, action: #selector(faceTapped), for: .valueChanged)
        
        notSureFaceView.imageForSelect = UIImage(named: "notSureWhite")
        notSureFaceView.imageForDeselect = UIImage(named: "notSureBlack")
        notSureFaceView.faceToggle.tag = 2
        notSureFaceView.faceToggle.addTarget(self, action: #selector(faceTapped), for: .valueChanged)
        
        feelingRefreshedFaceView.imageForSelect = UIImage(named: "amazingWhite")
        feelingRefreshedFaceView.imageForDeselect = UIImage(named: "amazingBlack")
        feelingRefreshedFaceView.faceToggle.tag = 3
        feelingRefreshedFaceView.faceToggle.addTarget(self, action: #selector(faceTapped), for: .valueChanged)
    }
    
    @objc
    func faceTapped(sender: FaceToggle) {
        if(sender != selectedFace) {
            selectedFace?.isOn = false
            selectedFace = sender
        }
        
        switch sender.tag {
        case 1: ratingsVCDelegate?.setRatingsFor(rating: .blendEffectRatings(.notEffective), indexOfPageVC: indexInPageVC)
        case 2:
            ratingsVCDelegate?.setRatingsFor(rating: .blendEffectRatings(.notSure), indexOfPageVC: indexInPageVC)
        case 3:
            ratingsVCDelegate?.setRatingsFor(rating: .blendEffectRatings(.feelingRefreshed), indexOfPageVC: indexInPageVC)
        default: print("Rating...")
        }
    }
}
