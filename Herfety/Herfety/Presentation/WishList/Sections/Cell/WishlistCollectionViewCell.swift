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
    var order: WishlistItem!
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
    func configureOrder(with order: WishlistItem) {
        self.order = order
    }
    
    private func configure() {
        imageCell.contentMode = .scaleAspectFit
        
        nameCell.font = .callout
        descriptionCell.font = .caption1
        descriptionCell.textColor = Colors.labelGray
        
        priceCell.font = .callout
        
        addCartBtn.applyStyle(.primaryButton, title: L10n.Reviews.addToCart)
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
        /// Remove From Whishlist
    }
    
    @IBAction func addToCart(_ sender: UIButton) {
        guard var product = order else { return }
        
        Task {
            let dataStore = DataStore.shared
            let isInCart = await dataStore.isItemInCart(productId: product.productID ?? 92)
            
            if !isInCart {
                var cartItem = await dataStore.getCartItems()
                product.qty = 1
                cartItem.append(product)
                await dataStore.updateCartItems(cartItem, showAlert: .add)
            } else {
                await MainActor.run {
                    AppDataStorePublisher.shared.notifyCartUpdate(showAlert: .add)
                }
            }
        }
    }
}
