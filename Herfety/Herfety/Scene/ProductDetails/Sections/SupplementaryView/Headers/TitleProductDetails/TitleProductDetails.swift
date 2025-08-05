//
//  TitleProductDetailss.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 28/02/2025.
//

import UIKit

class TitleProductDetails: UICollectionReusableView {
    
    // MARK: - Properties
    static let identifier: String = "TitleProductDetails"
    private var product: Wishlist?
    
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var avaliableLabel: UILabel!
    @IBOutlet weak var whishlistBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
}
// MARK: - Configuration
//
extension TitleProductDetails {
    
    func configure(titleLabl: String, priceLabel: String, avaliableLabel: String) {
        self.titleLabel.text = titleLabl
        self.priceLabel.text = priceLabel
        self.avaliableLabel.text = avaliableLabel
    }
    
    private func configureUI() {
        titleLabel.font = .title3
        priceLabel.font = .body
        avaliableLabel.font = .body
    }
    
    /// Configure the product Details
    ///
    ///  - Parameter product: The `product` containing the data to be displayed in `whishlist` page
    func configureProduct(with product: Wishlist) {
        self.product = product
    }
}
// MARK: - Actions
//
extension TitleProductDetails {
    @IBAction func addToWhishlist(_ sender: Any) {
        
        guard let product = product else { return }
        
        Task {
            let appDataStore = AppDataStore.shared
            let isInWishlist = await appDataStore.isItemInWishlist(productId: product.productID ?? 1)
            
            if !isInWishlist {
                await appDataStore.addToWishlist(
                    userId: appDataStore.userId,
                    productId: product.productID ?? 1
                )
            }
            appDataStore.isWishlistItemDeleted.send(false)
        }
    }
}
