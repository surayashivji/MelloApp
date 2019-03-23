//
//  ProfileViewController.swift
//  MelloApp
//
//  Created by Suraya Shivji on 3/22/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

class ProfileViewController: MLOHamburgerMenuViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Setup
    let manager = FirebaseManager()
    
    // MARK: Outlets
    @IBOutlet weak var historyTableView: UITableView!
    
    @IBOutlet weak var statsContainer: UIView!
    @IBOutlet weak var historyView: UIView!
    
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var statsButton: UIButton!
    
    // Stats Values
    @IBOutlet weak var timeDiffusedLabel: UILabel!
    @IBOutlet weak var totalSessionsLabel: UILabel!
    @IBOutlet weak var currentStreakLabel: UILabel!
    @IBOutlet weak var longestStreakLabel: UILabel!
    
    
    var isStatsVisible = true
    let disabledText = UIColor.disabledText
    let enabledText = UIColor.white
    var history = [[String:String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.historyTableView.delegate = self
        self.historyTableView.dataSource = self
        
        setupStats()
        fetchHistory()
    }
    
    // MARK: Actions
    @IBAction func historyViewTapped(_ sender: Any) {
        if isStatsVisible {
            // hide stats, show history
            statsContainer.isHidden = true
            historyView.isHidden = false
            
            // stats is hidden
            isStatsVisible = !isStatsVisible
            historyButton.setTitleColor(enabledText, for: .normal)
            statsButton.setTitleColor(disabledText, for: .normal)
            
        }
    }
    
    @IBAction func statsViewTapped(_ sender: Any) {
        if !isStatsVisible {
            // show stats, hide history
            statsContainer.isHidden = false
            historyView.isHidden = true
            
            // stats is visible
            isStatsVisible = !isStatsVisible
            historyButton.setTitleColor(disabledText, for: .normal)
            statsButton.setTitleColor(enabledText, for: .normal)
        }
    }
    
    func setupStats() {
        
    }
    
    func fetchHistory() {
        print("fetching history")
        manager.getUserBlendHistory { (userHistory) in
            print("here i am")
            self.history = userHistory
            print(self.history.count)
            DispatchQueue.main.async {
                print("here")
                self.historyTableView.reloadData()
            }
        }
    }
    
    // MARK: Table View Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count")
        print(self.history.count)
        return self.history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let blend = history[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! HistoryTableViewCell
        cell.blendNameLabel.text = blend["blendID"]
        cell.timeBlendLabel.text = blend["startTime"]
        return cell
    }
    
}
