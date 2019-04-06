//
//  SideMenuViewController.swift
//  MelloApp
//
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController {
    @IBOutlet weak var devicesAndIntegrationsContainer: UIView!
    @IBOutlet weak var subscriptionMenuContainer: UIView!
    @IBOutlet weak var customerSupportMenuContainer: UIView!
    @IBOutlet weak var settingsMenuContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setupGestureRecognizers()
        setupNotificationObservers()
        
    }
    
    @objc
    func didTapMenu(sender: UITapGestureRecognizer) {
        guard let tag = sender.view?.tag else { return }
        print("Tag...", tag)
        switch tag {
            case 1:
                let devicesAndIntegrationsVC = DeviceAndIntegrationsViewController.instantiate(fromAppStoryboard: .DevicesAndIntegrations)
                present(devicesAndIntegrationsVC, animated: true, completion: nil)
        case 4:
            let settingsVC = SettingsNavViewController.instantiate(fromAppStoryboard: .Settings)
            present(settingsVC, animated: true, completion: nil)
            
        case 2:
            let ratingsVC = RatingsViewController.instantiate(fromAppStoryboard: .Ratings)
            ratingsVC.viewHeight = 239
            present(ratingsVC, animated: true, completion: nil)
        default:
            print("Not implemented yet...")
        }
    }
    
    func setupGestureRecognizers() {
        let devicesTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapMenu))
        let subscriptionTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapMenu))
        let customerSupportTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapMenu))
        let settingsTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapMenu))
        devicesAndIntegrationsContainer.addGestureRecognizer(devicesTapGestureRecognizer)
        subscriptionMenuContainer.addGestureRecognizer(subscriptionTapGestureRecognizer)
        settingsMenuContainer.addGestureRecognizer(settingsTapGestureRecognizer)
        customerSupportMenuContainer.addGestureRecognizer(customerSupportTapGestureRecognizer)
    }
    
    internal func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(showThanksPopUp), name: .showThanksForRating, object: nil)
    }
    
    @objc
    func showThanksPopUp() {
        print("Showing... Thanks popup...")
        let thanksVC = ThanksViewController.instantiate(fromAppStoryboard: .Ratings)
        thanksVC.viewHeight = 81
        thanksVC.viewCornerRadius = 0
        present(thanksVC, animated: true, completion: nil)
    }
}

