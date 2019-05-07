//
//  DailyScheduleDataSource.swift
//  MelloApp
//
//  Created by Harrison Weinerman on 4/1/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

class DailyScheduleDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    var homeViewController: MLOHomeViewController
    var schedule = UserScentManager.schedule(for: nil)
    var tableView: UITableView?
    
    init(homeViewController: MLOHomeViewController) {
        self.homeViewController = homeViewController
        tableView = homeViewController.dailyScheduleTableView
    }
    
    func setDate(_ date: Date?) {
        schedule = UserScentManager.schedule(for: date)
        homeViewController.dailyScheduleHeight = CGFloat(50 * schedule.count)
        tableView?.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return schedule.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath)
            as? ScheduleItemTableViewCell else { return UITableViewCell() }
        cell.setup(schedule[indexPath.section], delegate: homeViewController)
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
