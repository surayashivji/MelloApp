//
//  HistoryTableViewCell.swift
//  MelloApp
//
//  Created by Suraya Shivji on 3/23/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var blendNameLabel: UILabel!
    @IBOutlet weak var timeBlendLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
