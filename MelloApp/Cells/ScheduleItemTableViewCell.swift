//
//  ScheduleItemTableViewCell.swift
//  MelloApp
//
//  Created by Harrison Weinerman on 4/1/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

class ScheduleItemTableViewCell: UITableViewCell {
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    var delegate: ScheduleItemTableViewCellDelegate?
    
    func setup(_ data: ScheduledBlend, delegate: ScheduleItemTableViewCellDelegate) {
        self.delegate = delegate
        leftImageView.image = data.scentImage
        titleLabel.text = data.scentName
        subtitleLabel.text = timeRange(data.start, data.end)
    }
    
    private func timeRange(_ date1: Date, _ date2: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: date1) + " - " + formatter.string(from: date2)
    }
    
    @IBAction func editPressed(_ sender: Any) {
        delegate?.editSchedule()
    }
}

protocol ScheduleItemTableViewCellDelegate {
    func editSchedule()
}
