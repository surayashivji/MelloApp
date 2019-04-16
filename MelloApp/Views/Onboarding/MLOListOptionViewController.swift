//
//  MLOSelectableOptionView.swift
//  MelloApp
//
//  Created by Harrison Weinerman on 2/24/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

/// a view controller that presents options for selection
class MLOListOptionViewController:
    MLOOnboardingViewController,
    UITableViewDelegate,
    UITableViewDataSource {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var nextViewController: UIViewController?

    // Queue UI updates until UI is loaded
    private var needsUpdate = false
    /// the type of selectable options--changes options and title
    var type: MLOSelectableOptionType? {
        didSet {
            if needsUpdate { updateUI() }
            needsUpdate = true
        }
    }
    
    /// the options that this view should prompt
    private var options = [MLOSelectableListOption]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    private func updateUI() {
        guard let type = type else { return }
        titleLabel.text = type.title
        subtitleLabel.text = type.subtitle
        options = type.options
        view.layoutIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if needsUpdate {
            updateUI()
            needsUpdate = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @objc override func nextButtonTapped() {
        guard selectedOptions().count > 0 else {
            alert(error: "Select at least 1 option to continue.")
            return
        }
        
        super.nextButtonTapped()
        guard let nextDisplayType = type?.nextOption?.displayType else {
            return
        }
        
        // Determine type of next onboarding page
        let nextViewController: UIViewController
        switch nextDisplayType {
        case .list:
            guard let next = storyboard?.instantiateViewController(withIdentifier: "list")
                as? MLOListOptionViewController else { return }
            next.type = type?.nextOption
            nextViewController = next
        case .grid:
            guard let next = storyboard?
                .instantiateViewController(withIdentifier: "grid") else { return }
            nextViewController = next
        }
        saveState()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        if let navigationController = navigationController as? MLOOnboardingNavigationController {
            navigationController.decrementProgressIndicator()
            navigationController.popViewController(animated: true)
        }
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 58
    }
    
    /// returns list of options that are selected by the user
    func selectedOptions() -> [MLOSelectableListOption] {
        var selectedOptions = [MLOSelectableListOption]()
        for i in 0..<options.count {
            guard let cell = tableView.cellForRow(at:
                IndexPath(row: i, section: 0)) as? MLOOptionTableViewCell else {
                break
            }
            if let option = cell.option, cell.isOptionSelected {
                selectedOptions.append(option)
            }
        }
        return selectedOptions
    }
    
    private func saveState() {
        guard let page = type?.rawValue else { return }
        let options = selectedOptions().map({ $0.title })
//        FirebaseManager.instance.user?.setValue(options, forKey: page)
        FirebaseManager.instance.setUserPreference(data: [page : options])
    }
}
