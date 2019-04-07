//
//  RatingsPageViewController.swift
//  MelloApp
//
//  Created by Suraya Shivji on 26/03/2019.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

class RatingsPageViewController: UIPageViewController {
    internal lazy var ratingPages: [UIViewController] = {
        let smellRatingVC = SmellRatingViewController.instantiate(fromAppStoryboard: .Ratings)
        smellRatingVC.ratingsVCDelegate = self
        smellRatingVC.view.layer.cornerRadius = 30
        smellRatingVC.view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        smellRatingVC.indexInPageVC = 0
        
        let energizerRatingVC = EnergizerRatingViewController.instantiate(fromAppStoryboard: .Ratings)
        energizerRatingVC.ratingsVCDelegate = self
        energizerRatingVC.view.layer.cornerRadius = 30
        energizerRatingVC.view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        energizerRatingVC.indexInPageVC = 1
        
        let repeatBlendRatingVC = RepeatBlendRatingViewController.instantiate(fromAppStoryboard: .Ratings)
        repeatBlendRatingVC.ratingsVCDelegate = self
        repeatBlendRatingVC.view.layer.cornerRadius = 30
        repeatBlendRatingVC.view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        repeatBlendRatingVC.indexInPageVC = 2
        
        return [
            smellRatingVC, energizerRatingVC, repeatBlendRatingVC
        ]
    }()
    
    var currentPage: Int = 0
    
    var pageControl = UIPageControl()
    var ratingsDelegate: RatingsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        dataSource = self
        if let firstViewController = ratingPages.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        delegate = self
        configurePageControl()
    }
    
    func goToNext(ratings: Int) {
        if ratings >= ratingPages.count || ratings < 0 {return}
        setViewControllers([ratingPages[ratings]], direction: (ratings < currentPage) ? .reverse: .forward, animated: true) { (completed) in
            self.currentPage = ratings
            self.pageControl.currentPage = ratings
            print("Completed...", completed)
        }
    }
}


extension RatingsPageViewController: UIPageViewControllerDelegate {
    func configurePageControl() {
        pageControl = UIPageControl(frame: CGRect(x: 0,y: 190,width: UIScreen.main.bounds.width,height: 50))
        self.pageControl.numberOfPages = ratingPages.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.black
        self.pageControl.pageIndicatorTintColor = #colorLiteral(red: 0.6823529412, green: 0.7058823529, blue: 0.8039215686, alpha: 1)
        self.pageControl.currentPageIndicatorTintColor = UIColor.black
        print("Adding page C")
        self.view.addSubview(pageControl)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = ratingPages.index(of: pageContentViewController)!
        
        let currentPageIndex = ratingPages.index(of: pageContentViewController)!
        currentPage = currentPageIndex
        print("Current Index", currentPageIndex)
    }
}

extension RatingsPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = ratingPages.index(of: viewController) else {
            currentPage = 0
            return nil
        }

        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            currentPage = 0
            return nil
        }
        
        guard ratingPages.count > previousIndex else {
            currentPage = 0
            return nil
        }
        currentPage = previousIndex
        return ratingPages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = ratingPages.index(of: viewController) else {
            currentPage = ratingPages.count - 1
            return nil
        }
        
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = ratingPages.count
        
        guard orderedViewControllersCount != nextIndex else {
            currentPage = ratingPages.count - 1
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            currentPage = ratingPages.count - 1
            return nil
        }
        
        currentPage = nextIndex
        return ratingPages[nextIndex]
    }
    
    
}

extension RatingsPageViewController: RatingsViewControllerDelegate {
    func setRatingsFor(rating: Ratings, indexOfPageVC: Int) {
        goToNext(ratings: indexOfPageVC + 1)
    }
}


