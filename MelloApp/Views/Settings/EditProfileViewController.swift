//
//  EditProfileViewController.swift
//  MelloApp
//
//  Created by Suraya Shivji on 28/03/2019.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

class EditProfileViewController: UITableViewController {
    
    // MARK: Setup
    let manager = FirebaseManager.instance
    
    var headers: [String] = ["FULL NAME", "EMAIL", "PASSWORD"]
    
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserInfo()
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func getUserInfo() {
        manager.getUserInformation { (userInformation) in
            if let info = userInformation {
                let name = info["name"] as? String
                let email = info["email"] as? String
                self.fullNameTextField.text = name
                self.emailTextField.text = email
            }
        }
    }
    
    // MARK: Table View Methods
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 47
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let label = UILabel()
        label.textColor = .white
        headerView.backgroundColor = #colorLiteral(red: 0.1187841371, green: 0.131008029, blue: 0.2608371079, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 10)
        label.text = headers[section]
        label.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(label)
        headerView.addConstraint(NSLayoutConstraint(item: headerView, attribute: .leading, relatedBy: .equal, toItem: label, attribute: .leading, multiplier: 1, constant: -15))
        headerView.addConstraint(NSLayoutConstraint(item: headerView, attribute: .top, relatedBy: .equal, toItem: label, attribute: .top, multiplier: 1, constant: 0))
        headerView.addConstraint(NSLayoutConstraint(item: headerView, attribute: .bottom, relatedBy: .equal, toItem: label, attribute: .bottom, multiplier: 1, constant: 0))
        headerView.addConstraint(NSLayoutConstraint(item: headerView, attribute: .trailing, relatedBy: .equal, toItem: label, attribute: .trailing, multiplier: 1, constant: 0))
        return headerView
    }
}
