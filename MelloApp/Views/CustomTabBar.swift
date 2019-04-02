//
//  CustomTabBar.swift
//  MelloApp
//
//  Created by Suraya Shivji on 3/22/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

class CustomTabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBar.barTintColor = UIColor.tabBarBackground
        tabBar.tintColor = UIColor.white
        tabBar.unselectedItemTintColor = UIColor.white
    }

}
