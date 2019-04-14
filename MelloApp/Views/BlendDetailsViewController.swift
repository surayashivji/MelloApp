//
//  BlendDetailsViewController.swift
//  MelloApp
//
//  Created by Suraya Shivji on 4/9/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

class BlendDetailsViewController: UIViewController {
    
    var currentBlend: ScentBlend?
    
    @IBOutlet weak var blendNameLabel: UILabel!
    @IBOutlet weak var blendDescriptionLabel: UILabel!
    
    @IBOutlet weak var ingredientOne: UIImageView!
    @IBOutlet weak var ingredientTwo: UIImageView!
    @IBOutlet weak var ingredientThree: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let blendLoaded = currentBlend {
            setupBlendDetails(blendLoaded)
        }
        if let b = currentBlend {
            print("jamie")
            print(b.name)
        }
   
    }
    
    func setupBlendDetails(_ blend: ScentBlend) {
        blendNameLabel.text = blend.name
        blendDescriptionLabel.text = blend.ingredients
    }
    
    // MARK: Actions
    @IBAction func diffuseNowTapped(_ sender: Any) {
    }
    
    @IBAction func scheduleLaterTapped(_ sender: Any) {
    }
    

}
