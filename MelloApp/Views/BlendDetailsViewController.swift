//
//  BlendDetailsViewController.swift
//  MelloApp
//
//  Created by Suraya Shivji on 4/9/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

class BlendDetailsViewController: UIViewController {
    
    @IBOutlet weak var blendNameLabel: UILabel!
    @IBOutlet weak var blendDescriptionLabel: UILabel!
    
    @IBOutlet weak var ingredientOne: UIImageView!
    @IBOutlet weak var ingredientTwo: UIImageView!
    @IBOutlet weak var ingredientThree: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: Actions
    @IBAction func diffuseNowTapped(_ sender: Any) {
    }
    
    @IBAction func scheduleLaterTapped(_ sender: Any) {
    }
    

}
