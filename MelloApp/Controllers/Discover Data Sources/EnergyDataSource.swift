//
//  EnergyDataSource.swift
//  MelloApp
//
//  Created by Suraya Shivji on 4/6/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

class EnergyDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let energyblends = UserScentManager.energyblends()
    let manager = FirebaseManager()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return energyblends.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "scentCell", for: indexPath)
            as? MLOScentCollectionViewCell else { return UICollectionViewCell() }
        cell.setup(scent: energyblends[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath as IndexPath) as? MLOScentCollectionViewCell {
//           performSegue(withIdentifier: "goToBlendDetails", sender: self)
            print("here")
        }
    }
}
