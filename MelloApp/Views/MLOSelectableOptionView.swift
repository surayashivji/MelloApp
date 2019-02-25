//
//  MLOSelectableOptionView.swift
//  MelloApp
//
//  Created by Harrison Weinerman on 2/24/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

enum MLOSelectableOptionType {
    case timeOfDay, goal, mindfulness
    
    var options: [MLOSelectableListOption] {
        switch self {
        case .timeOfDay:
            return [MLOSelectableListOption(title: "When I wake up",
                                            defaultColor: .purple,
                                            selectionColor: .white)]
        case .goal:
            return [MLOSelectableListOption(title: "When I wake up",
                                            defaultColor: .purple,
                                            selectionColor: .white)]
        case .mindfulness:
            return [MLOSelectableListOption(title: "When I wake up",
                                            defaultColor: .purple,
                                            selectionColor: .white)]
        }
    }
}

struct MLOSelectableListOption {
    var title: String
    var defaultColor: UIColor
    var selectionColor: UIColor
}

class MLOSelectableOptionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MLOSelectableOptionViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    private var options: [MLOSelectableListOption] = []
    
//    var selectedOptions: [MLOSelectableListOption] = []
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "optionCell") as? MLOOptionTableViewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        cell.option = options[indexPath.row]
        
        
        return cell
    }
    
    func selectedOptions() -> [MLOSelectableListOption] {
        var options = [MLOSelectableListOption]()
        for i in 0..<options.count {
            guard let cell = tableView.cellForRow(at:
                IndexPath(row: i, section: 0)) as? MLOOptionTableViewCell else {
                break
            }
            if let option = cell.option, cell.isOptionSelected {
                options.append(option)
            }
        }
        return options
    }
    
//
//    func didSelect(option: MLOSelectableListOption) {
//        selectedOptions.append(option)
//    }
//
//    func didDeselect(option: MLOSelectableListOption) {
//        selectedOptions.removeAll(where: { $0 == option })
//    }
    
//    init(_ type: MLOSelectableOptionType) {
//        options = type.options
//    }

}

protocol MLOSelectableOptionViewDelegate {
//    func didSelect(option: MLOSelectableListOption)
//    func didDeselect(option: MLOSelectableListOption)
}
