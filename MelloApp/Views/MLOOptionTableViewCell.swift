//
//  MLOOptionTableViewCell.swift
//  MelloApp
//
//  Created by Harrison Weinerman on 2/25/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

class MLOOptionTableViewCell: UITableViewCell {
    /// button to select the option. not using cell selection
    /// so taps outside of bounds don't register
    @IBOutlet weak var button: UIButton!
    
    /// the image view dispalying a checkmark or circle when cell selected/deselected
    @IBOutlet weak var selectionImage: UIImageView!
    
    /// the option that this cell is representing
    var option: MLOSelectableListOption? {
        didSet {
            isOptionSelected = false
        }
    }
    
    /// if true, means option is selected. when set, updates UI
    var isOptionSelected = false {
        didSet {
            guard let option = option else {
                return
            }
            
            if isOptionSelected {
                button.backgroundColor = option.selectionColor
                selectionImage.image = #imageLiteral(resourceName: "checkmark")
            } else {
                button.backgroundColor = option.defaultColor
                selectionImage.image = #imageLiteral(resourceName: "deselected")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // left align text
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        // corner radius
        clipsToBounds = true
        layer.cornerRadius = 10
    }

    /// action for when cell button is pressed
    @IBAction func selected(_ sender: Any) {
        isOptionSelected = !isOptionSelected
    }
    
}
