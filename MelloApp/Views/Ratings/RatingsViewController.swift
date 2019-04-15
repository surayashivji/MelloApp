//
//  RatingsViewController.swift
//  MelloApp
//
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

class RatingsViewController: ModalBaseViewController {

    var smellRating: Ratings.SmellRatings? = .unrated
    var effectivenessRating: Ratings.BlendEffectRatings? = .unrated
    var wouldUseAgainRating: Ratings.WouldUseAgainRatings? = .unrated
    
    var containerViewController: RatingsPageViewController?
    let containerSegueName = "ratingPagesSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == containerSegueName {
            containerViewController = segue.destination as? RatingsPageViewController
        }
    }
    
    @IBAction func skip(_ sender: UIButton) {
        self.dismiss(animated: true){
            print("About to post...")
            NotificationCenter.default.post(name: .showThanksForRating, object: nil)
        }
    }
    
    func setRatingsFor(_ rating: Ratings) {
        switch rating {
        case let .blendEffectRatings(blendEffectRating):
            self.effectivenessRating = blendEffectRating
        case let .smellRatings(smellRating):
            self.smellRating = smellRating
        case let .wouldUseAgainRatings(wouldUseAgainRating):
            self.wouldUseAgainRating = wouldUseAgainRating
        }
    }
}

protocol RatingsViewControllerDelegate {
    func setRatingsFor(rating: Ratings, indexOfPageVC: Int)
}
