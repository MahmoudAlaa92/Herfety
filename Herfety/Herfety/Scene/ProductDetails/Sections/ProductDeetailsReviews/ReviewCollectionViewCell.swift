//
//  ReviewCollectionViewCell.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 01/03/2025.
//

import UIKit

class ReviewCollectionViewCell: UICollectionViewCell {

    static let identifier = "ReviewCollectionViewCell"
    
    @IBOutlet weak var contentElement: UIView!
    @IBOutlet weak var imageReviewer: UIImageView!
    @IBOutlet weak var commentReviewer: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
}
// MARK: - Configuration
//
extension ReviewCollectionViewCell {
    private func configureUI() {
        contentElement.backgroundColor = Colors.hTextFieldUnderLine
        contentElement.layer.cornerRadius = 12
        contentElement.clipsToBounds = true
        
        imageReviewer.layer.cornerRadius = imageReviewer.layer.frame.size.width / 2
        imageReviewer.clipsToBounds = true
        
        commentReviewer.font = .body
    }
}
