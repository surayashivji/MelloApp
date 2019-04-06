//
//  HorizontalCollectionView.swift
//  FLAnimatedImage
//
//  Created by Harrison Weinerman on 3/26/19.
//

import UIKit

class HorizontalCollectionView: UICollectionView {
    override func awakeFromNib() {
        let flowLayout = (collectionViewLayout as? UICollectionViewFlowLayout)
        flowLayout?.scrollDirection = .horizontal
        flowLayout?.minimumInteritemSpacing = 0.0
    }
}
