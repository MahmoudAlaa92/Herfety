//
//  WishlistCollectionViewCell.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 10/02/2025.
//

import UIKit

class WishlistCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "WishlistCollectionViewCell"
    
    // MARK: - Outelets
    //
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageCell: UIImageView!
    
    @IBOutlet weak var nameCell: UILabel!
    @IBOutlet weak var descriptionCell: UILabel!
    
    @IBOutlet weak var priceCell: UILabel!
    
    @IBOutlet weak var addCartBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configure()
        configureContainerView()
    }
    
}
// MARK: - Configure
//
extension WishlistCollectionViewCell {
    private func configure() {
        imageCell.contentMode = .scaleAspectFit
        
        nameCell.font = .callout
        descriptionCell.font = .caption1
        descriptionCell.textColor = Colors.labelGray
        
        priceCell.font = .callout
        
        addCartBtn.applyStyle(.primaryButton, title: "Add to Cart")
    }
    
    /// Configures the appearance of the container view, including shadows and corner radius.
    private func configureContainerView() {
        
        containerView.backgroundColor = Colors.hMainTheme
        containerView.layer.shadowColor = Colors.hPrimaryButton.cgColor
        containerView.layer.shadowOffset = .zero
        containerView.layer.shadowOpacity = 0.2
        containerView.layer.shadowRadius = 5
        containerView.layer.cornerRadius = 20
    }
}

// MARK: - Actions
//
extension WishlistCollectionViewCell {
    
    @IBAction func removeFromWhishlist(_ sender: UIButton) {
        // Remove From Whishlist
        print("Remove From Whishlist")
    }
    
    @IBAction func addToCart(_ sender: UIButton) {
        // Add To Cart
        print("Add to Cart")
    }
}
