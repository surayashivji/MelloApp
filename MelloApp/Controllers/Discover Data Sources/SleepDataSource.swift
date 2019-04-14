//
//  EnergyDataSource.swift
//  MelloApp
//
//  Created by Suraya Shivji on 4/6/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

class SleepDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let sleepblends = UserScentManager.sleepblends()
    let manager = FirebaseManager()
    
    weak var delegate: DetailsDelegate?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sleepblends.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "scentCell", for: indexPath)
            as? MLOScentCollectionViewCell else { return UICollectionViewCell() }
        cell.setup(scent: sleepblends[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath as IndexPath) as? MLOScentCollectionViewCell {
            delegate?.didPressBlend(sleepblends[indexPath.row])
        }
    }
}
