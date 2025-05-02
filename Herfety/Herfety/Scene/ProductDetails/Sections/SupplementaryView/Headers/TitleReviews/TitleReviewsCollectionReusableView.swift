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
    var onShowReviewrsTapped: (() -> Void)?
    // MARK: - Outlets
    @IBOutlet weak var titleReview: UILabel!
    
    @IBOutlet weak var reviewsBtn: UIButton!
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
        reviewsBtn.setTitle("(\(numberOfReviews) Review)", for: .normal)
        cosmosView.rating = Double(rating)
    }
    
    private func configureUI() {
        titleReview.text  = "Reviews"
        titleReview.font = .calloutBold
        
        let attributedTitle = NSAttributedString(
            string: "showAll",
            attributes: [
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .foregroundColor: Colors.primaryBlue,
                .font: UIFont.body
            ])
        reviewsBtn.setAttributedTitle(attributedTitle, for: .normal)

        reviewsBtn.backgroundColor = .clear
        reviewsBtn.setTitleColor(.black, for: .normal)
        starView.addSubview(cosmosView)
        
        cosmosView.translatesAutoresizingMaskIntoConstraints = false
//        cosmosView.frame = starView.bounds
        cosmosView.settings.filledImage = Images.iconRating
        cosmosView.settings.emptyImage = Images.iconRatingEmpty
        cosmosView.settings.starSize = 17
        cosmosView.settings.updateOnTouch = false
    }
}
// MARK: - Actions
//
extension TitleReviewsCollectionReusableView {
    
    @IBAction func showReviewers(_ sender: Any) {
        onShowReviewrsTapped?()
    }
}
