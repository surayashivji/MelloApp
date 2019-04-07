//
//  PreferenceCollectionViewCell.swift
//  MelloApp
//
//  Created by Suraya Shivji on 28/03/2019.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

class PreferenceCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var preferenceButton: PreferenceButtonView!  {
        didSet {
            preferenceButton.layer.cornerRadius = 15
            preferenceButton.layer.masksToBounds = true
        }
    }
}
