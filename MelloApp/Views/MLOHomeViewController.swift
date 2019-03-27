//
//  MLOHomeViewController.swift
//  MelloApp
//
//  Created by Harrison Weinerman on 3/21/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

enum HomeBannerStyle {
    case now(String), next(String)
}

class MLOHomeViewController: MLOHamburgerMenuViewController {
    @IBOutlet weak var scheduleCollectionView: UICollectionView!
    @IBOutlet weak var recommendationsCollectionView: UICollectionView!
    @IBOutlet weak var favoritesCollectionView: UICollectionView!
    
    @IBOutlet weak var banner: UIView!
    @IBOutlet weak var bannerEditButton: UIButton!
    @IBOutlet weak var bannerTitle: UILabel!
    @IBOutlet weak var bannerSubtitle: UILabel!
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var bannerHeightConstraint: NSLayoutConstraint!
    private let bannerHeight: CGFloat = 95
    
    private lazy var scheduleDataSource = ScheduleDataSource()
    private lazy var recommendationsDataSource = RecommendationsDataSource()
    private lazy var favoritesDataSource = FavoritesDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        scheduleCollectionView.dataSource = scheduleDataSource
        scheduleCollectionView.delegate = scheduleDataSource
        recommendationsCollectionView.dataSource = recommendationsDataSource
        recommendationsCollectionView.delegate = recommendationsDataSource
        favoritesCollectionView.dataSource = favoritesDataSource
        favoritesCollectionView.delegate = favoritesDataSource
    }
    
    func setBanner(style: HomeBannerStyle?) {
        guard let style = style else {
            bannerHeightConstraint.constant = 0
            return
        }
        bannerHeightConstraint.constant = bannerHeight
        switch style {
        case .now(let id):
            bannerTitle.text = id
            bannerSubtitle.text = "Currently Diffusing"
        case .next(let id):
            bannerTitle.text = id
            bannerSubtitle.text = "Tomorrow"
        }
        view.layoutIfNeeded()
    }
    
    @IBAction func bannerEditPressed(_ sender: Any) {
        
    }
}
