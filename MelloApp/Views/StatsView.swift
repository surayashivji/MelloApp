//
//  StatsView.swift
//  MelloApp
//
//  Created by Suraya Shivji on 3/22/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

class StatsView: UIView {
    
    //MARK: awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        setupStatsView()
    }
    
    private func setupStatsView() {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }

}
