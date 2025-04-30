//
//  WishlistCollectionViewCell.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 10/02/2025.
//

import UIKit

class WishlistCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let identifier: String = "WishlistCollectionViewCell"
    var order: Products!
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
    
    
    /// Configure the order Details
    ///
    ///  - Parameter order: The `order` containing the data to be displayed in `wishlist` page
    ///
    func configureOrder(with order: Products) {
        self.order = order
    }
    
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
        containerView.layer.shadowColor = Colors.primaryBlue.cgColor
        containerView.layer.shadowOffset = .zero
        containerView.layer.shadowOpacity = 0.15
        containerView.layer.shadowRadius = 2
        containerView.layer.cornerRadius = 20
    }
}

// MARK: - Actions
//
extension WishlistCollectionViewCell {
    
    @IBAction func removeFromWhishlist(_ sender: UIButton) {
        // Remove From Whishlist
    }
    
    @IBAction func addToCart(_ sender: UIButton) {
        if !CustomeTabBarViewModel.shared.orders.contains(where: { $0 == self.order }) {
            // TODO: change this logic in future
            order.qty = 1
            CustomeTabBarViewModel.shared.orders.append(order)
        }    }
}
