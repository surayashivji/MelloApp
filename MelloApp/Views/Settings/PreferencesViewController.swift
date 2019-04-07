//
//  PreferencesViewController.swift
//  MelloApp
//
//  Created by Suraya Shivji on 28/03/2019.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit


protocol PreferencesDelegate {
    func selectPreference(preference: Preferences, insert: Bool)
}


class PreferencesViewController: UITableViewController {
    
    var diffuseTimesPreferences: [Preferences.DiffuseTimes] = []
    var goalsPreferences: [Preferences.Goals] = []
    var mindfulnessActivitiesPreferences: [Preferences.MindfullnessActivities] = []
    var diffuseTimePreference: Preferences.DiffuseTime = .notset
    var aromaticPreferences: [Preferences.AromaticPreferences] = []

    
    var preferences: [[String: [String]]] =
        [
            ["title": ["DIFFUSE TIMES"], "values":["Morning", "Mid-day", "Night"]],
            ["title": ["GOALS"], "values": ["Focus", "Relax", "Balance", "Energize"]],
            ["title": ["MINDFULNESS ACTIVITIES"], "values": ["Sleep", "Meditation", "Work-out", "Socialize", "Music"]],
            ["title": ["DIFFUSE TIME"], "values": ["15 MIN", "20 MIN", "25 MIN", "30 MIN", "45 MIN", "60 MIN"]],
            ["title": ["AROMATIC PREFERENCES"], "values": ["Citrus", "Floral", "Green", "Woody"]]
        ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "preferencesCellID", for: indexPath) as! PreferrencesTableViewCell
        cell.preferenceOptions = preferences[indexPath.section]
        cell.title = preferences[indexPath.section]["title"]?[0] ?? ""
        cell.tableViewSection = indexPath.section
        cell.preferencesDelegate = self
        return cell
    }
    
    
    
    @IBAction func goBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        print("Count...", preferences.count)
        return preferences.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0, 1, 4: return 50
        case 2, 3: return 100
        default: return 50
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 28
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 10)
        label.text = preferences[section]["title"]?[0]
        label.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(label)
        headerView.addConstraint(NSLayoutConstraint(item: headerView, attribute: .leading, relatedBy: .equal, toItem: label, attribute: .leading, multiplier: 1, constant: -15))
        headerView.addConstraint(NSLayoutConstraint(item: headerView, attribute: .top, relatedBy: .equal, toItem: label, attribute: .top, multiplier: 1, constant: 0))
        headerView.addConstraint(NSLayoutConstraint(item: headerView, attribute: .bottom, relatedBy: .equal, toItem: label, attribute: .bottom, multiplier: 1, constant: 0))
        headerView.addConstraint(NSLayoutConstraint(item: headerView, attribute: .trailing, relatedBy: .equal, toItem: label, attribute: .trailing, multiplier: 1, constant: 0))
        return headerView
    }
}

extension PreferencesViewController: PreferencesDelegate {
    func selectPreference(preference: Preferences, insert: Bool) {
        switch preference {
        case .diffuseTimes(let selection):
            let index = diffuseTimesPreferences.lastIndex(of: selection)
            if let itemIndex = index {
                if !insert  {
                    diffuseTimesPreferences.remove(at: itemIndex)
                }
            } else {
                if insert {
                    diffuseTimesPreferences.append(selection)
                }
            }
        case .goals(let selection):
            let index = goalsPreferences.lastIndex(of: selection)
            if let itemIndex = index {
                if !insert {
                    goalsPreferences.remove(at: itemIndex)
                }
            } else {
                if insert {
                    goalsPreferences.append(selection)
                }
            }
        case .mindfullnessActivities(let selection):
            let index = mindfulnessActivitiesPreferences.lastIndex(of: selection)
            if let itemIndex = index {
                if !insert {
                    mindfulnessActivitiesPreferences.remove(at: itemIndex)
                }
            } else {
                if insert {
                    mindfulnessActivitiesPreferences.append(selection)
                }
            }
        case .aromaticPreferences(let selection):
            let index = aromaticPreferences.lastIndex(of: selection)
            if let itemIndex = index {
                if !insert {
                    aromaticPreferences.remove(at: itemIndex)
                }
            } else {
                if insert {
                    aromaticPreferences.append(selection)
                }
            }
        case .diffuseTime(let selection):
            if insert {
                diffuseTimePreference = selection
            } else {
                diffuseTimePreference = .notset
            }
        }
        
        print("All Preferences... ", diffuseTimesPreferences, goalsPreferences, mindfulnessActivitiesPreferences, aromaticPreferences, diffuseTimePreference)
    }
}
