//
//  HomeViewController.swift
//  MelloApp
//
//  Created by Suraya Shivji on 2/3/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit
import FLAnimatedImage

class HomeViewController: UIViewController {
    
    // MARK: Constants
    
    // MARK: Outlets
    @IBOutlet weak var blobImageView: FLAnimatedImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animateGif()
    }
    
    // MARK: Actions
    @IBAction func getStartedDidTouch(_ sender: Any) {
    }
    
    
    @IBAction func loginDidTouch(_ sender: Any) {
    }
    
    func animateGif() {
        if let path = Bundle.main.path(forResource: "test", ofType: "gif") {
            let url = URL(fileURLWithPath: path)
            let gifData = try? Data(contentsOf: url)
            let imageData = FLAnimatedImage(animatedGIFData: gifData)
            blobImageView.animatedImage = imageData
        } else {
            // Gif not found
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

}
