//
//  DiscoverViewController.swift
//  MelloApp
//
//  Created by Suraya Shivji on 4/6/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController {
    @IBOutlet weak var energyCollectionView: InsetCollectionView!
    @IBOutlet weak var sleepCollectionView: InsetCollectionView!
    @IBOutlet weak var relaxCollectionView: InsetCollectionView!
    
    private lazy var energyDataSource = EnergyDataSource()
//    private lazy var sleepDataSource = SleepDataSource()
//    private lazy var relaxDataSource = RelaxDataSource()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        energyCollectionView.dataSource = energyDataSource
        energyCollectionView.delegate = energyDataSource
        
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

}
