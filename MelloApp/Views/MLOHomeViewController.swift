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

class MLOHomeViewController: MLOHamburgerMenuViewController, ScheduleItemTableViewCellDelegate {
    
    @IBOutlet weak var scheduleCollectionView: UICollectionView!
    @IBOutlet weak var recommendationsCollectionView: UICollectionView!
    @IBOutlet weak var favoritesCollectionView: UICollectionView!
    
    @IBOutlet weak var dailyScheduleTableView: UITableView!
    @IBOutlet weak var dailyScheduleHeightConstraint: NSLayoutConstraint!
    var dailyScheduleHeight: CGFloat = 49
    
    @IBOutlet weak var banner: UIView!
    @IBOutlet weak var bannerEditButton: UIButton!
    @IBOutlet weak var bannerTitle: UILabel!
    @IBOutlet weak var bannerSubtitle: UILabel!
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var bannerHeightConstraint: NSLayoutConstraint!
    private let bannerHeight: CGFloat = 95
    
    private lazy var dailyScheduleDataSource = DailyScheduleDataSource(homeViewController: self)
    private lazy var scheduleDataSource = ScheduleDataSource(dailyScheduleDataSource: dailyScheduleDataSource,
                                                             homeViewController: self)
    
    private lazy var recommendationsDataSource = RecommendationsDataSource()
    private lazy var favoritesDataSource = FavoritesDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        scheduleCollectionView.dataSource = scheduleDataSource
        scheduleCollectionView.delegate = scheduleDataSource
        
        dailyScheduleTableView.dataSource = dailyScheduleDataSource
        dailyScheduleTableView.delegate = dailyScheduleDataSource
        
        recommendationsCollectionView.dataSource = recommendationsDataSource
        recommendationsCollectionView.delegate = recommendationsDataSource
        
        favoritesCollectionView.dataSource = favoritesDataSource
        favoritesCollectionView.delegate = favoritesDataSource
        
        setDailyScheduleHidden(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        [scheduleCollectionView, favoritesCollectionView, recommendationsCollectionView].forEach({
            scrollToBeginning(collectionView: $0)
        })
        setBanner(style: .none)
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
    
    func setDailyScheduleHidden(_ isHidden: Bool) {
        dailyScheduleHeightConstraint.constant = isHidden ? 0 : dailyScheduleHeight
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func bannerEditPressed(_ sender: Any) {
        
    }
    
    private func scrollToBeginning(collectionView: UICollectionView) {
        collectionView.setContentOffset(CGPoint(x: -26, y: 0), animated: false)
    }
    
    func editSchedule() {
        performSegue(withIdentifier: "schedule", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let edit = segue.destination as? EditScheduleViewController {
            edit.presenter = self
        }
    }
}
