//
//  MLOGridOptionViewController.swift
//  MelloApp
//
//  Created by Harrison Weinerman on 3/10/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

class MLOGridOptionViewController:
    MLOOnboardingViewController,
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let type = MLOSelectableOptionType.scents 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func nextButtonTapped() {
        performSegue(withIdentifier: "finish", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        titleLabel.text = type.title
        subtitleLabel.text = type.subtitle
        view.layoutIfNeeded()
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        if let navigationController = navigationController as? MLOOnboardingNavigationController {
            navigationController.decrementProgressIndicator()
            navigationController.popViewController(animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return type.options.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "grid", for: indexPath) as? MLOGridOptionCollectionViewCell else { return UICollectionViewCell() }
        cell.option = type.options[indexPath.item]
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        (collectionView.cellForItem(at: indexPath) as? MLOGridOptionCollectionViewCell)?.isOptionSelected.toggle()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width / 2) - 10
        let height = width * (110 / 150) // aspect ratio
        return CGSize(width: width, height: height)
    }
    
    /// returns list of options that are selected by the user
    func selectedOptions() -> [MLOSelectableListOption] {
        var options = [MLOSelectableListOption]()
        for i in 0..<options.count {
            guard let cell = collectionView.cellForItem(at:
                IndexPath(row: i, section: 0)) as? MLOGridOptionCollectionViewCell else {
                    break
            }
            if let option = cell.option, cell.isOptionSelected {
                options.append(option)
            }
        }
        return options
    }
}
