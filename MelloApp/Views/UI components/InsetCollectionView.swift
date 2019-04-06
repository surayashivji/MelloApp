//
//  InsetCollectionView.swift
//  MelloApp
//
//  Created by Harrison Weinerman on 4/1/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

class InsetCollectionView: HorizontalCollectionView {
    override func awakeFromNib() {
        super.awakeFromNib()
        contentInset = UIEdgeInsetsMake(0, 26, 0, 26)
        showsHorizontalScrollIndicator = false
    }
}
