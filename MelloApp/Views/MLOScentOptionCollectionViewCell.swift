//
//  MLOScentOptionCollectionViewCell.swift
//  MelloApp
//
//  Created by Harrison Weinerman on 3/19/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit
import UIImageViewAlignedSwift

struct MLOScentOption {
    var name: String
    var ingredients: String
    var color: UIColor
    var image: UIImage
    
    static let citrus = MLOScentOption(name: "Balance Out Citrus",
                                       ingredients: "orange, lavender, mint",
                                       color: .brightPink,
                                       image: #imageLiteral(resourceName: "citrus"))
    static let floral = MLOScentOption(name: "Focus Floral",
                                      ingredients: "orange, lavender, mint",
                                      color: .brightGreen,
                                      image: #imageLiteral(resourceName: "floral"))
    static let green = MLOScentOption(name: "Sleepy Green",
                                       ingredients: "lavender, cinnamon, mint",
                                       color: .brightPurple,
                                       image: #imageLiteral(resourceName: "green"))
}

class MLOScentOptionCollectionViewCell: UICollectionViewCell {
    
    var scent: MLOScentOption? {
        didSet {
            titleLabel.text = scent?.name
            subtitleLabel.text = scent?.ingredients
            sideImageView.image = scent?.image
            sideImageView.alignment = .right
            sideImageView.alpha = 0.7
            backgroundColor = scent?.color
            layer.cornerRadius = 10
            layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var sideImageView: UIImageViewAligned!
}
