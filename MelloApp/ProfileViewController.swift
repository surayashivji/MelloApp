//
//  ProfileViewController.swift
//  MelloApp
//
//  Created by Suraya Shivji on 3/22/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

class ProfileViewController: MLOHamburgerMenuViewController, UITableViewDataSource, UITableViewDelegate, DiffuseButtonDelegate {
    
    // MARK: Setup
    let manager = FirebaseManager.instance
    
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
    
    private var isStatsVisible = true
    private let disabledText = UIColor.disabledText
    private let enabledText = UIColor.white
    
    var history = [[String:Any]]()
    var stats = [String:String]()
    
    let cellSpacingHeight: CGFloat = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.historyTableView.delegate = self
        self.historyTableView.dataSource = self
        self.historyTableView.tableFooterView = UIView()
        self.historyTableView.backgroundView = nil;
        self.historyTableView.backgroundColor = UIColor.clear
        
        fetchStats()
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
        timeDiffusedLabel.text = stats["timeDiffused"]
        totalSessionsLabel.text = stats["totalSessions"]
        currentStreakLabel.text = stats["currentStreak"]
        longestStreakLabel.text = stats["longestStreak"]
    }
    
    // MARK: Data Querying
    
    func fetchStats() {
        manager.getUserStats { (userStats) in
            if let stats = userStats {
                self.stats = stats
                DispatchQueue.main.async {
                    self.setupStats()
                }
            }
        }
    }
    
    func fetchHistory() {
        manager.getUserBlendHistory { (userHistory) in
            if let history = userHistory {
                self.history = history
                DispatchQueue.main.async {
                    self.historyTableView.reloadData()
                }
            }
        }
    }
    
    func selectIconFor(aroma: String, benefit: String) -> UIImage? {
        let path = "\(aroma)\(benefit).png"
        return UIImage(named: path)
    }
    
    func didPressDiffuse(_ tag: Int) {
        self.alertUserOf(title: "Connect your mello to start diffusing!", message: "Connect your mello to start diffusing", completion: {_ in })
    }
    
    // MARK: Table View Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let blend = history[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! HistoryTableViewCell
        cell.selectionStyle = .none
        cell.delegate = self
        cell.diffusePlayButton.tag = indexPath.section
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        if let blendID = blend["blend_ID"] {
            manager.getBlendQualities(blendID: blendID as! String) { (name, aromaQuality, benefitQuality) in
                cell.iconImageView.image = self.selectIconFor(aroma: aromaQuality, benefit: benefitQuality)
                cell.blendNameLabel.text = name
            }
        }
        let timestamp = blend["timestamp"] as! Double
        let date = Date(timeIntervalSince1970: timestamp/1000)
        cell.timeBlendLabel.text = date.asString(style: .medium)
        return cell
    }
    
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.history.count
    }
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
}
