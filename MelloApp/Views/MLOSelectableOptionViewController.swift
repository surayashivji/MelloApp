//
//  MLOSelectableOptionView.swift
//  MelloApp
//
//  Created by Harrison Weinerman on 2/24/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

/// a view controller that presents options for selection
class MLOSelectableOptionViewController:
    UIViewController,
    UITableViewDelegate,
    UITableViewDataSource {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    /// the type of selectable options--changes options and title
    var type: MLOSelectableOptionType? {
        didSet {
            guard let type = type else { return }
            titleLabel.text = type.title
            subtitleLabel.text = type.subtitle
            options = type.options
            view.layoutIfNeeded()
        }
    }
    
    /// the options that this view should prompt
    private var options = [MLOSelectableListOption]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: Table View methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:
            "optionCell") as? MLOOptionTableViewCell else {
            return UITableViewCell()
        }
        cell.option = options[indexPath.row]
        return cell
    }
    
    /// returns list of options that are selected by the user
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


}
