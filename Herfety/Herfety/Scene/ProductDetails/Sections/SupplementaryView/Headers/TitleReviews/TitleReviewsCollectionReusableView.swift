//
//  TitleReviewsCollectionReusableView.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 02/03/2025.
//

import UIKit

class TitleReviewsCollectionReusableView: UICollectionReusableView {

    // MARK: - Properties
    static let identifier = "TitleReviewsCollectionReusableView"
    
    // MARK: - Outlets
    @IBOutlet weak var titleReview: UILabel!
    @IBOutlet weak var imageReview: UIImageView!
    @IBOutlet weak var numberReviews: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
}

// MARK: - Configuration
//
extension TitleReviewsCollectionReusableView {
    
    func configure(numberOfReviews: Int) {
        self.numberReviews.text = "(\(numberOfReviews) Review)"
    }
    
    private func configureUI() {
        titleReview.text  = "Reviews"
        titleReview.font = .calloutBold
        
        numberReviews.font = .body
        
        imageReview.image = Images.iconRating
    }
}
