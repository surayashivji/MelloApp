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
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        delegate?.didPressDiffuse(sender.tag)
    }
    
}
