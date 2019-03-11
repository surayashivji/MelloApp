//
//  MLOGridOptionCollectionViewCell.swift
//  MelloApp
//
//  Created by Harrison Weinerman on 3/10/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

class MLOGridOptionCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var checkmarkImageView: UIImageView!
    @IBOutlet weak var sideImageView: UIImageView!
    
    var option: MLOSelectableListOption? {
        didSet {
            isOptionSelected = false
            titleLabel.text = option?.title
            sideImageView.image = #imageLiteral(resourceName: "homelogo.png")
        }
    }
    var isOptionSelected = false {
        didSet {
            self.checkmarkImageView.image = self.isOptionSelected ? #imageLiteral(resourceName: "checkmark") : #imageLiteral(resourceName: "deselected")
            
            if isOptionSelected {
                titleLabel.textColor = option?.selectionTextColor
                backgroundColor = option?.selectionColor
            } else {
                titleLabel.textColor = .white
                backgroundColor = .mediumPurple
            }
        }
    }
}
