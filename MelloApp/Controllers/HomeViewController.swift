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
    
    // MARK: Outlets
    @IBOutlet weak var blobImageView: FLAnimatedImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animateGif()
        // Remove "back" title from navigation bar for next segue
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true;
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false;
    }
    
    // MARK: Actions
    
    func animateGif() {
        if let path = Bundle.main.path(forResource: "blob", ofType: "gif") {
            let url = URL(fileURLWithPath: path)
            let gifData = try? Data(contentsOf: url)
            let imageData = FLAnimatedImage(animatedGIFData: gifData)
            blobImageView.animatedImage = imageData
        } else {
            // Gif not found
            // TODO: Error Handling
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startOnboarding",
            let navigationController = segue.destination as? UINavigationController,
            let vc = navigationController.topViewController as? MLOListOptionViewController {
            vc.view.layoutIfNeeded()
            vc.type = .timeOfDay
        }
    }

}
