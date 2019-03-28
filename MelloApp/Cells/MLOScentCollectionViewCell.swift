//
//  MLOScentCollectionViewCell.swift
//  MelloApp
//
//  Created by Harrison Weinerman on 3/26/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

class MLOScentCollectionViewCell: MLORoundCollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var scentLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var topBar: UIView!
    private var scent: ScentBlend?
    
    func setup(scent: ScentBlend) {
        self.scent = scent
        imageView.image = scent.image
        scentLabel.text = scent.name
        ingredientsLabel.text = scent.ingredients
        topBar.backgroundColor = scent.color
        updateFavoriteIcon()
    }
    
    private func updateFavoriteIcon() {
        favoriteButton.setImage(scent?.isFavorite ?? false ? #imageLiteral(resourceName: "favorited") : #imageLiteral(resourceName: "unfavorited"), for: .normal)
    }
    
    @IBAction func favoriteButtonPressed(_ sender: Any) {
        let scentTitle = NSAttributedString(string: scent?.name ?? "scent",
                                            attributes: [.font : UIFont.italicSystemFont(ofSize: 13)])
        let alertMessage = NSMutableAttributedString(attributedString: scentTitle)
        let addedRemoved = scent?.isFavorite ?? true ? "added to" : "removed from"
        let addedMessage = NSAttributedString(string: " \(addedRemoved) your favorites",
            attributes: [.font : UIFont.systemFont(ofSize: 13, weight: .semibold)])
        alertMessage.append(addedMessage)
        BannerPresenter.shared.presentLower(text: alertMessage, icon: #imageLiteral(resourceName: "Image"))
        updateFavoriteIcon()
    }
    
    @IBAction func runButtonPressed(_ sender: Any) {
    }
    
}
