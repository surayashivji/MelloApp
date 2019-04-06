//
//  MLODateCollectionViewCell,swift
//  MelloApp
//
//  Created by Harrison Weinerman on 3/26/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

class MLODateCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var connectionLine: UIView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    var isSelectedCell = false
    
    func setSelected(_ isSelected: Bool) {
        UIView.animate(withDuration: 0.2) {
            self.isSelectedCell = isSelected
            self.connectionLine.isHidden = !isSelected
            self.containerView.backgroundColor = isSelected ? .white : .mediumPurple
            [self.monthLabel, self.dayLabel].forEach({ $0?.textColor = isSelected ? .darkPurple : .white })
        }
    }
}
