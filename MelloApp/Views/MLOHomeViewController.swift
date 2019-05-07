//
//  MLOHomeViewController.swift
//  MelloApp
//
//  Created by Harrison Weinerman on 3/21/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

enum HomeBannerStyle {
    case now(Int), later(Int), tomorrow(Int)
}

class MLOHomeViewController: MLOHamburgerMenuViewController, ScheduleItemTableViewCellDelegate, HomeViewControllerBannerDelegate {
    
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
    lazy var scheduleDataSource = ScheduleDataSource(dailyScheduleDataSource: dailyScheduleDataSource,
                                                             homeViewController: self)
    
    private lazy var recommendationsDataSource = RecommendationsDataSource()
    private lazy var favoritesDataSource = FavoritesDataSource()
    
    private var editingEvent: ScheduledBlend?
    private var schedule: [ScheduledBlend]?
    private var nextBlend: ScheduledBlend?
    
    func updateBanner() {
        schedule = UserScentManager.schedule(for: Date())
        guard let schedule = schedule else {
            setBanner(style: .none)
            return
        }
        for event in schedule {
            if isHappening(event.start, event.end) {
                nextBlend = event
                setBanner(style: .now(event.scentId))
                return
            }
        }
        
        for event in schedule {
            if isUpcoming(event.start) {
                nextBlend = event
                setBanner(style: .later(event.scentId))
                return
            }
        }
        self.schedule = UserScentManager.schedule(for: Calendar.current.date(byAdding: .day, value: 1, to: Date()))
        guard let tomorrowSchedule = self.schedule, let first = tomorrowSchedule.first else {
            setBanner(style: .none)
            return
        }
        nextBlend = first
        setBanner(style: .tomorrow(first.scentId))
    }
    
    private func isHappening(_ date1: Date, _ date2: Date) -> Bool {
        let now = Date()
        let components1 = Calendar.current.dateComponents([.hour, .minute], from: date1)
        guard let todayWithDate1Time = Calendar.current.date(bySettingHour: components1.hour ?? 0,
                                                             minute: components1.minute ?? 0,
                                                             second: 0,
                                                             of: now) else { return false }
        
        let components2 = Calendar.current.dateComponents([.hour, .minute], from: date2)
        guard let todayWithDate2Time = Calendar.current.date(bySettingHour: components2.hour ?? 0,
                                                             minute: components2.minute ?? 0,
                                                             second: 0,
                                                             of: now) else { return false }
        return now < todayWithDate2Time && now >= todayWithDate1Time
    }
    
    private func isUpcoming(_ date1: Date) -> Bool {
        let now = Date()
        let components1 = Calendar.current.dateComponents([.hour, .minute], from: date1)
        guard let todayWithDate1Time = Calendar.current.date(bySettingHour: components1.hour ?? 0,
                                                             minute: components1.minute ?? 0,
                                                             second: 0,
                                                             of: now) else { return false }
        return now < todayWithDate1Time
    }
    
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
        
        FirebaseManager.instance.bannerDelegate = self
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
            bannerSubtitle.text = "Currently Diffusing"
            if let blend = FirebaseManager.instance.scentBlend(from: id) {
                bannerTitle.text = blend.name
                bannerImage.image = blend.image
                banner.backgroundColor = blend.color
            }
        case .tomorrow(let id):
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm"
            
            let italics = NSAttributedString(string: "Tomorrow at \(timeFormatter.string(from: nextBlend?.start ?? Date()))",
                                                attributes: [.font : UIFont.italicSystemFont(ofSize: 10)])
            let upNext = NSAttributedString(string: "Up Next - ",
                attributes: [.font : UIFont.systemFont(ofSize: 10, weight: .semibold)])
            let title = NSMutableAttributedString(attributedString: upNext)
            title.append(italics)
            
            bannerSubtitle.attributedText = title
            if let blend = FirebaseManager.instance.scentBlend(from: id) {
                bannerTitle.text = blend.name
                bannerImage.image = blend.image
                banner.backgroundColor = blend.color
            }
        case .later(let id):
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm"
            
            let italics = NSAttributedString(string: "Today at \(timeFormatter.string(from: nextBlend?.start ?? Date()))",
                attributes: [.font : UIFont.italicSystemFont(ofSize: 10)])
            let upNext = NSAttributedString(string: "Up Next - ",
                                            attributes: [.font : UIFont.systemFont(ofSize: 10, weight: .semibold)])
            let title = NSMutableAttributedString(attributedString: upNext)
            title.append(italics)
            
            bannerSubtitle.attributedText = title
            if let blend = FirebaseManager.instance.scentBlend(from: id) {
                bannerTitle.text = blend.name
                bannerImage.image = blend.image
                banner.backgroundColor = blend.color
            }
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
        editSchedule(event: nextBlend)
    }
    
    private func scrollToBeginning(collectionView: UICollectionView) {
        collectionView.setContentOffset(CGPoint(x: -26, y: 0), animated: false)
    }
    
    func editSchedule(event: ScheduledBlend?) {
        editingEvent = event
        performSegue(withIdentifier: "schedule", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let edit = segue.destination as? EditScheduleViewController {
            edit.presenter = self
            edit.event = editingEvent
        }
    }
}

protocol HomeViewControllerBannerDelegate {
    func updateBanner()
}
