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
    var product: Products!
    
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
    func configureProduct(with product: Products) {
        self.product = product
    }
    
}
// MARK: - Actions
//
extension TitleProductDetails {
    @IBAction func addToWhishlist(_ sender: Any) {
        if !CustomeTabBarViewModel.shared.Wishlist.contains(where: { $0 == self.product }) {
            let productItems: ProductsOfWishlistRemote = ProductsOfWishlistRemote(network: AlamofireNetwork())
            productItems.addNewProduct(userId: 1, productId: product.id ?? 1) { result in
                CustomeTabBarViewModel.shared.fetchWishlistItems(id: 1)
            }
        }
    }
}
