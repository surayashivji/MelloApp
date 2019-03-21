//
//  MLODrawerController.swift
//  MelloApp
//
//  Created by Harrison Weinerman on 3/20/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit
import MMDrawerController

class MLODrawerController {
    static var drawer: MMDrawerController?
    static func setupDrawer() -> UIViewController? {
        guard let menu = UIStoryboard.init(name: "Menu", bundle: nil)
            .instantiateInitialViewController(),
            let root = UIStoryboard.init(name: "TabBarController", bundle: nil)
                .instantiateInitialViewController() else {
                return nil
        }
        let drawer = MMDrawerController(center: root, leftDrawerViewController: menu)
        drawer?.openDrawerGestureModeMask = .all
        drawer?.closeDrawerGestureModeMask = .all
        self.drawer = drawer
        return drawer
    }
}
