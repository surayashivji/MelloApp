//
//  ScheduleDataSource.swift
//  MelloApp
//
//  Created by Harrison Weinerman on 3/26/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

class ScheduleDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    lazy var dates: [Date] = upcomingWeek()
    private let monthFormatter = DateFormatter()
    private let dayFormatter = DateFormatter()
    
    override init() {
        super.init()
        monthFormatter.dateFormat = "MMMM"
        dayFormatter.dateFormat = "d"
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "dateCell", for: indexPath)
            as? MLODateCollectionViewCell else { return UICollectionViewCell() }
        let date = dates[indexPath.item]
        cell.monthLabel.text = monthFormatter.string(from: date)
        cell.dayLabel.text = dayFormatter.string(from: date)
        return cell
    }
    
    private func upcomingWeek() -> [Date] {
        var dates: [Date] = []
        for i in 0...6 {
            if let date = Calendar.current.date(byAdding: .day, value: i, to: Date()) {
                dates.append(date)
            }
        }
        return dates
    }
    
}
