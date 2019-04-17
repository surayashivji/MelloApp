//
//  DiscoverViewController.swift
//  MelloApp
//
//  Created by Suraya Shivji on 4/6/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController, DetailsDelegate, DiffuseButtonDelegate {
    
    @IBOutlet weak var energyCollectionView: InsetCollectionView!
    @IBOutlet weak var sleepCollectionView: InsetCollectionView!
    @IBOutlet weak var relaxCollectionView: InsetCollectionView!
    
    private lazy var energyDataSource = EnergyDataSource()
    private lazy var sleepDataSource = SleepDataSource()
    private lazy var relaxDataSource = RelaxDataSource()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        energyCollectionView.dataSource = energyDataSource
        energyCollectionView.delegate = energyDataSource
        
        sleepCollectionView.dataSource = sleepDataSource
        sleepCollectionView.delegate = sleepDataSource
        
        relaxCollectionView.dataSource = relaxDataSource
        relaxCollectionView.delegate = relaxDataSource
        
        // Make navigation bar transparent
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        // Remove "back" title from navigation bar for next segue
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        energyDataSource.delegate = self
        sleepDataSource.delegate = self
        relaxDataSource.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        [energyCollectionView, sleepCollectionView, relaxCollectionView].forEach({
            scrollToBeginning(collectionView: $0)
        })
    }
    
    private func scrollToBeginning(collectionView: UICollectionView) {
        collectionView.setContentOffset(CGPoint(x: -26, y: 0), animated: false)
    }
    
    func didPressBlend(_ blend: ScentBlend) {
        let storyboard = UIStoryboard(name: "BlendDetails", bundle: nil)
        let destinationVC = storyboard.instantiateInitialViewController() as! BlendDetailsViewController
        destinationVC.currentBlend = blend
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    // MARK: Diffuse
    
    func didPressDiffuse(_ tag: Int) {
        self.alertUserOf(title: "Connect your mello to start diffusing!", message: "Connect your mello to start diffusing", completion: {_ in })
    }

}
