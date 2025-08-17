//
//  ReviewersCollectionViewCell.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 03/03/2025.
//

import UIKit
import Cosmos

class ReviewersCollectionViewCell: UICollectionViewCell {

    static let identifier = "ReviewersCollectionViewCell"
    lazy var cosmosView = CosmosView()
    ///
    @IBOutlet weak var effectView: UIView!
    @IBOutlet weak var contentImage: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameReviewer: UILabel!
    @IBOutlet weak var dateReviewer: UILabel!
    @IBOutlet weak var commentReviewer: UILabel!
    @IBOutlet weak var starView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureIU()
    }
}
// MARK: - Configuration
//
extension ReviewersCollectionViewCell {
    
    private func configureIU() {
        contentImage.layer.cornerRadius = 12
        contentImage.clipsToBounds = true
        
        starView.addSubview(cosmosView)
        
        cosmosView.frame = starView.bounds
        cosmosView.settings.filledImage = Images.iconRating
        cosmosView.settings.emptyImage = Images.iconRatingEmpty
        cosmosView.settings.starSize = 15
        cosmosView.settings.updateOnTouch = false
        /// Outlets
        nameReviewer.font = .callout
        
        dateReviewer.font = .caption1
        dateReviewer.textColor = Colors.hCardTextFieldPlaceholder
        
        commentReviewer.font = .body2
        commentReviewer.numberOfLines = 0
        commentReviewer.lineBreakMode = .byWordWrapping
        /// shadow View
        effectView.backgroundColor = Colors.hMainTheme
        effectView.layer.shadowColor = Colors.primaryBlue.cgColor
        effectView.layer.shadowOffset = .zero
        effectView.layer.shadowOpacity = 0.15
        effectView.layer.shadowRadius = 2
        
        effectView.layer.cornerRadius = 13
    }
}
