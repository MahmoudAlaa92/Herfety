//
//  TitleReviewsCollectionReusableView.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 02/03/2025.
//

import UIKit
import Cosmos

class TitleReviewsCollectionReusableView: UICollectionReusableView {

    // MARK: - Properties
    static let identifier = "TitleReviewsCollectionReusableView"
    lazy var cosmosView = CosmosView()
    
    // MARK: - Outlets
    @IBOutlet weak var titleReview: UILabel!
    @IBOutlet weak var numberReviews: UILabel!
    @IBOutlet weak var starView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
}
// MARK: - Configuration
//
extension TitleReviewsCollectionReusableView {
    
    func configure(numberOfReviews: Int, rating: Double) {
        self.numberReviews.text = "(\(numberOfReviews) Review)"
        
        cosmosView.rating = Double(rating)
    }
    
    private func configureUI() {
        titleReview.text  = "Reviews"
        titleReview.font = .calloutBold
        
        numberReviews.font = .body
        
        starView.addSubview(cosmosView)
        
        cosmosView.translatesAutoresizingMaskIntoConstraints = false
//        cosmosView.frame = starView.bounds
        cosmosView.settings.filledImage = Images.iconRating
        cosmosView.settings.emptyImage = Images.iconRatingEmpty
        cosmosView.settings.starSize = 17
        cosmosView.settings.updateOnTouch = false
    }
}
