//
//  MLOOnboardingFinishViewController.swift
//
//  Created by Harrison Weinerman on 3/19/19.
//

import UIKit

class MLOOnboardingFinishViewController:
    UIViewController,
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionView: UICollectionView!

    var scents: [MLOScentOption] = [.citrus, .floral, .green]
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return scents.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "scent", for: indexPath)
            as? MLOScentOptionCollectionViewCell else { return UICollectionViewCell() }
        cell.scent = scents[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 85, height: 80)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        let flowLayout = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)
        flowLayout?.scrollDirection = .horizontal
        flowLayout?.minimumInteritemSpacing = 0.0
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.shadowImage = UIImage()
        (navigationController as? MLOOnboardingNavigationController)?.progressIndicator.isHidden = true
    }
    
}
