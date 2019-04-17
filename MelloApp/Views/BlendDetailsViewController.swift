//
//  BlendDetailsViewController.swift
//  MelloApp
//
//  Created by Suraya Shivji on 4/9/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

class BlendDetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var currentBlend: ScentBlend?
    
    @IBOutlet weak var blendNameLabel: UILabel!
    @IBOutlet weak var blendDescriptionLabel: UILabel!
    @IBOutlet weak var oilsCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if let blendLoaded = currentBlend {
            setupBlendDetails(blendLoaded)
        }
        
        oilsCollectionView.delegate = self
        oilsCollectionView.dataSource = self
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    func setupBlendDetails(_ blend: ScentBlend) {
        blendNameLabel.text = blend.name
        blendDescriptionLabel.text = blend.description
    }
    
    // MARK: Actions
    @IBAction func diffuseNowTapped(_ sender: Any) {
    }
    
    @IBAction func scheduleLaterTapped(_ sender: Any) {
    }
    
    // Collection View Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentBlend?.ingredients.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "oilCell", for: indexPath)
            as? OilCell else { return UICollectionViewCell() }
        if let oil = currentBlend?.ingredients[indexPath.row] {
            cell.oilImageView.image = UIImage(named: "\(oil)")
            cell.oilLabel.text = oil
        }
        return cell
    }
}
