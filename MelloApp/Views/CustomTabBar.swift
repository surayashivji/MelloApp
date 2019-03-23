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
        
        self.tabBar.barTintColor = UIColor.tabBarBackground
        self.tabBar.tintColor = UIColor.white
        self.tabBar.unselectedItemTintColor = UIColor.white
    }

}
