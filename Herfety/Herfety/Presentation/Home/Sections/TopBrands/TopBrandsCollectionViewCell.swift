//
//  TopBrandsCollectionViewCell.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 09/02/2025.
//

import UIKit

class TopBrandsCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties
    //
    static let identifier: String = "TopBrandsCollectionViewCell"
    
    // MARK: - Outlets
    //
    @IBOutlet weak var backGroundView: UIImageView!
    @IBOutlet weak var nameBrands: UILabel!
    @IBOutlet weak var contentOfLogo: UIView!
    @IBOutlet weak var imageOfLogo: UIImageView!
    @IBOutlet weak var offerBrands: UILabel!
    @IBOutlet weak var imageOfBrands: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configure()
    }

}

// MARK: - Configure
//
extension TopBrandsCollectionViewCell {
    
    private func configure() {
        backGroundView.layer.cornerRadius = 10
        backGroundView.clipsToBounds = true
        
        nameBrands.font = .body2
        nameBrands.lineBreakMode = .byWordWrapping
        nameBrands.numberOfLines = 1
        
        contentOfLogo.layer.cornerRadius = 10
        contentOfLogo.clipsToBounds = true
        
        imageOfLogo.contentMode = .scaleAspectFill
        
        offerBrands.font = .body
        offerBrands.numberOfLines = 1
        
        imageOfBrands.contentMode = .scaleAspectFill
    }
}
