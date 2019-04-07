//
//  SettingsViewController.swift
//  MelloApp
//
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    // MARK: Setup
    let manager = FirebaseManager()

    var settingsItems: [[[String: String]]] = [
        [
            ["setting": "Edit Profile", "subItem": ""],
            ["setting": "Edit Preferences", "subItem": "Goals"]
        ],
        [
            ["setting": "Notifications", "subItem": "All"],
            ["setting": "Subscription", "subItem": "Auto Renew"]
        ]
    ]
    
    @IBOutlet var prefTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.separatorColor = .clear
        getUserInfo()
    }
    
    private func getUserInfo() {
        manager.getUserInformation { (userInformation) in
            if let info = userInformation {
                let name = info["name"] as? String
                self.settingsItems[0][0]["subItem"] = name
                self.prefTableView.reloadData()
            }
        }
    }
    
    
    @IBAction func goBAck(_ sender: UIButton) {
        print("go back selected")
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Table View Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCellId", for: indexPath) as? SettingsTableViewCell
        cell?.selectionStyle = .none
        cell?.settingsItemName.text = settingsItems[indexPath.section][indexPath.row]["setting"]
        cell?.subNameLabel.text = settingsItems[indexPath.section][indexPath.row]["subItem"]
        guard let settingsCell = cell else { return UITableViewCell() }
        return settingsCell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 28
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            if(indexPath.row ==  0) {
                let editProfileVC = EditProfileViewController.instantiate(fromAppStoryboard: .Settings)
                self.navigationController?.pushViewController(editProfileVC, animated: true)
            }
            
            if(indexPath.row ==  1) {
                let preferencesVC = PreferencesViewController.instantiate(fromAppStoryboard: .Settings)
                self.navigationController?.pushViewController(preferencesVC, animated: true)
            }

        default: print("Tapped...")
        }
    }
}
