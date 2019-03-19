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
            sideImageView.image = option?.defaultImage
        }
    }
    var isOptionSelected = false {
        didSet {
            UIView.animate(withDuration: 0.1) {
                self.checkmarkImageView.image = self.isOptionSelected ? self.option?.selectionImage : #imageLiteral(resourceName: "deselected")

                if self.isOptionSelected {
                    self.titleLabel.textColor = self.option?.selectionTextColor
                    self.backgroundColor = self.option?.selectionColor
                } else {
                    self.titleLabel.textColor = .white
                    self.backgroundColor = .mediumPurple
                }
            }
        }
    }
}
