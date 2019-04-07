//
//  PreferrencesTableViewCell.swift
//  MelloApp
//
//  Created by Suraya Shivji on 28/03/2019.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

class PreferrencesTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    var preferenceOptions: [String: [String]] = [:]
    var title: String = ""
    var tableViewSection: Int = 0
    var preferencesDelegate: PreferencesDelegate?
    
    var selectedPreferenceButton: PreferenceButton = PreferenceButton()
    var selectedItemIndex: Int = -1
    
    var selectedDiffuseTimePreferenceButton: PreferenceCollectionViewCell = PreferenceCollectionViewCell()
    
    var preferencesTable: [[Preferences]] = [[.diffuseTimes(.morning), .diffuseTimes(.midDay), .diffuseTimes(.night), .diffuseTimes(.notset)],[.goals(.focus), .goals(.relax), .goals(.balance), .goals(.energize), .goals(.notset)],[.mindfullnessActivities(.sleep), .mindfullnessActivities(.meditation), .mindfullnessActivities(.workOut), .mindfullnessActivities(.socialize), .mindfullnessActivities(.music), .mindfullnessActivities(.notset) ],[.diffuseTime(.fifteen(.off)), .diffuseTime(.twenty(.off)), .diffuseTime(.twentyFive(.off)), .diffuseTime(.thirty(.off)), .diffuseTime(.fortyFive(.off)), .diffuseTime(.sixty(.off)), .diffuseTime(.notset)],
                                             [.aromaticPreferences(.citrus), .aromaticPreferences(.floral), .aromaticPreferences(.green), .aromaticPreferences(.woody), .aromaticPreferences(.notset)]
        ]

    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

extension PreferrencesTableViewCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let margin: CGFloat = (self.frame.width - 296) / 5
        let edgeInsets = UIEdgeInsets(top: 0, left: margin, bottom: 0, right: margin)
        return edgeInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

extension PreferrencesTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = preferenceOptions["values"]?.count else { return 0}
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "preferenceCollectionViewCell", for: indexPath) as! PreferenceCollectionViewCell
        if tableViewSection == 3 {
            let preference = preferencesTable[tableViewSection][indexPath.item]
            
            switch preference {
            case .diffuseTime(let diffuseTime):
                cell.preferenceButton.preferenceButton.isOn = diffuseTime.turnedOn
            default:
                print("Some other preference")
            }
        }
        

        cell.preferenceButton.text = (preferenceOptions["values"] ?? [])[indexPath.row]
        cell.preferenceButton.preferenceButton.buttonIndexPath = PreferenceIndexPath.indexPath(row: indexPath.row, section: tableViewSection, item: indexPath.item)
        cell.preferenceButton.preferenceButton.actualIndexPath = indexPath
        cell.preferenceButton.preferenceButton.addTarget(self, action: #selector(preferenceSelected), for: .valueChanged)
        cell.preferenceButton.preferenceButton.tag = indexPath.row
        cell.preferenceButton.preferenceButton.itemIndex = indexPath.item
        return cell
    }
    

    
    @objc
    func preferenceSelected(sender: PreferenceButton) {
        var preference = preferencesTable[tableViewSection][sender.itemIndex]
        if tableViewSection == 3 {
            let turnOn = sender.isOn
            if sender.itemIndex != selectedItemIndex {
                turnOffPreviousPreference()
                turnOnPreference(sender: sender)
                preference = preferencesTable[tableViewSection][sender.itemIndex]
                preferencesDelegate?.selectPreference(preference: preference, insert: turnOn)
                selectedItemIndex = sender.itemIndex
            } else {
                switch preference {
                case .diffuseTime(var diffuseTime):
                    if sender.isOn {
                        diffuseTime.turnOn()
                    } else {
                        diffuseTime.turnOff()
                    }
                    preferencesTable[tableViewSection][sender.itemIndex] = .diffuseTime(diffuseTime)
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                default:
                    print("Some other preference")
                }
                preference = preferencesTable[tableViewSection][sender.itemIndex]
                preferencesDelegate?.selectPreference(preference: preference, insert: turnOn)
            }
        } else {
            let preference = preferencesTable[tableViewSection][sender.itemIndex]
            sender.isOn ? preferencesDelegate?.selectPreference(preference: preference, insert: true) : preferencesDelegate?.selectPreference(preference: preference, insert: false)
        }
    }
    
    func turnOffPreviousPreference() {
        if selectedItemIndex < 0 { return }
            let previousPreference = preferencesTable[tableViewSection][selectedItemIndex]
            switch previousPreference {
            case .diffuseTime(var diffuseTime):
                diffuseTime.turnOff()
                preferencesTable[tableViewSection][selectedItemIndex] = .diffuseTime(diffuseTime)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            default:
                print("Some other preference...")
            }
    }
    
    func turnOnPreference(sender: PreferenceButton) {
        let preference = preferencesTable[tableViewSection][sender.itemIndex]
        switch preference {
        case .diffuseTime(var diffuseTime):
            diffuseTime.turnOn()
            preferencesTable[tableViewSection][sender.itemIndex] = .diffuseTime(diffuseTime)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        default:
            print("Some other preference")
        }
    }
}

enum Preferences {
    
    case diffuseTimes(DiffuseTimes)
    case goals(Goals)
    case mindfullnessActivities(MindfullnessActivities)
    case diffuseTime(DiffuseTime)
    case aromaticPreferences(AromaticPreferences)
    
    
    enum DiffuseTimes {
        case notset
        case morning
        case midDay
        case night
    }
    
    enum Goals {
        case notset
        case focus
        case relax
        case balance
        case energize
    }
    
    enum MindfullnessActivities {
        case notset
        case sleep
        case meditation
        case workOut
        case socialize
        case music
    }
    
    enum DiffuseTime {
        case notset
        case fifteen(Toggle)
        case twenty(Toggle)
        case twentyFive(Toggle)
        case thirty(Toggle)
        case fortyFive(Toggle)
        case sixty(Toggle)
        
        
        
        
        var turnedOn: Bool {
            get {
                switch self {
                case .fifteen(let toggle):
                    if toggle == .on { return true}
                    return false
                case .twenty(let toggle):
                    if toggle == .on { return true}
                    return false
                case .twentyFive(let toggle):
                    if toggle == .on { return true}
                    return false
                case .thirty(let toggle):
                    if toggle == .on { return true}
                    return false
                case .fortyFive(let toggle):
                    if toggle == .on { return true}
                    return false
                case .sixty(let toggle):
                    if toggle == .on { return true}
                    return false
                default:
                    return false
                }
            }

        }
        
        mutating func turnOff() {
            switch self {
            case .fifteen(_):
                self =  .fifteen(.off)
   
            case .twenty(_):
                self =  .twenty(.off)
            case .twentyFive(_):
                self =  .twentyFive(.off)
            case .thirty(_):
                self =  .thirty(.off)
            case .fortyFive(_):
                self =  .fortyFive(.off)
            case .sixty(_):
                self =  .sixty(.off)
            default:
                self = .notset
            }
        }
        
        mutating func turnOn() {
            switch self {
            case .fifteen(_):
                self =  .fifteen(.on)
                
            case .twenty(_):
                self =  .twenty(.on)
            case .twentyFive(_):
                self =  .twentyFive(.on)
            case .thirty(_):
                self =  .thirty(.on)
            case .fortyFive(_):
                self =  .fortyFive(.on)
            case .sixty(_):
                self =  .sixty(.on)
            default:
                self = .notset
            }
        }
    }
    
    enum AromaticPreferences {
        case notset
        case citrus
        case floral
        case green
        case woody
    }
    
    enum Toggle {
        case on
        case off
    }
}
