//
//  DailyScheduleDataSource.swift
//  MelloApp
//
//  Created by Harrison Weinerman on 4/1/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

class DailyScheduleDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    var schedule = UserScentManager.schedule(for: nil)
    var tableView: UITableView?
    
    func setDate(_ date: Date?) {
        schedule = UserScentManager.schedule(for: date)
        tableView?.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return schedule.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath)
            as? ScheduleItemTableViewCell else { return UITableViewCell() }
        cell.setup(schedule[indexPath.row])
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        return cell
    }
}
