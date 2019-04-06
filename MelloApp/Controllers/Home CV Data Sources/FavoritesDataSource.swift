//
//  FavoritesDataSource.swift
//  MelloApp
//
//  Created by Harrison Weinerman on 3/26/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

class FavoritesDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    let favorites = UserScentManager.favorites()
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return max(favorites.count, 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if favorites.count == 0 {
            return collectionView
                .dequeueReusableCell(withReuseIdentifier: "noFavorites", for: indexPath)
            
        }
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "scentCell", for: indexPath)
            as? MLOScentCollectionViewCell else { return UICollectionViewCell() }
        cell.setup(scent: favorites[indexPath.item])
        return cell
    }
}
