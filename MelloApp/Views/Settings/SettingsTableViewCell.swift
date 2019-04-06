//
//  SettingsTableViewCell.swift
//  MelloApp
//
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    @IBOutlet weak var settingsItemName: UILabel!
    @IBOutlet weak var subNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
