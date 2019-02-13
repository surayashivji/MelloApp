//
//  ViewController+Alert.swift
//  MelloApp
//
//  Created by Suraya Shivji on 2/9/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

extension UIViewController {
    func alertUserOf(title: String, message: String, completion: @escaping (UIAlertAction?) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: completion)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
}


//func createUser(withEmail email: String, password: String, completion: @escaping (User?, Error?) -> Void) {
//    Auth.auth().createUser(withEmail: email, password: password, completion: completion)
//}

