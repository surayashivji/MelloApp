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
    private var dailyScheduleDataSource: DailyScheduleDataSource?
    private var homeViewController: MLOHomeViewController?
    
    convenience init(dailyScheduleDataSource: DailyScheduleDataSource,
                     homeViewController: MLOHomeViewController) {
        self.init()
        self.dailyScheduleDataSource = dailyScheduleDataSource
        self.homeViewController = homeViewController
    }
    
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
        cell.containerView.layer.cornerRadius = 10
        cell.clipsToBounds = true
        cell.setSelected(false)
        cell.monthLabel.text = monthFormatter.string(from: date)
        cell.dayLabel.text = dayFormatter.string(from: date)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? MLODateCollectionViewCell else { return }
        cell.setSelected(true)
        dailyScheduleDataSource?.setDate(dates[indexPath.row])
        homeViewController?.setDailyScheduleHidden(false)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? MLODateCollectionViewCell
        deselectContent(cell: cell)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let cell = collectionView.cellForItem(at: indexPath) as? MLODateCollectionViewCell
        if cell?.isSelectedCell ?? false {
            collectionView.deselectItem(at: indexPath, animated: false)
            deselectContent(cell: cell)
            return false
        }
        return true
    }
    
    
    private func deselectContent(cell: MLODateCollectionViewCell?) {
        cell?.setSelected(false)
        dailyScheduleDataSource?.setDate(nil)
        homeViewController?.setDailyScheduleHidden(true)
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
