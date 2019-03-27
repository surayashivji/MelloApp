//
//  HistoryTableViewCell.swift
//  MelloApp
//
//  Created by Suraya Shivji on 3/23/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

protocol DiffuseButtonDelegate : class {
    func didPressDiffuse(_ tag: Int)
}

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var blendNameLabel: UILabel!
    @IBOutlet weak var timeBlendLabel: UILabel!
    @IBOutlet weak var diffusePlayButton: UIButton!
    
    weak var delegate: DiffuseButtonDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        print("play tapped")
        delegate?.didPressDiffuse(sender.tag)
    }
    
}
