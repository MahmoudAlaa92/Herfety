//
//  CardOfProductCollectionViewCell.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 08/02/2025.
//
import UIKit

class CardOfProductCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    //
    static let cellIdentifier: String = "CardOfProductCollectionViewCell"
    var product: WishlistItem!
    var order: OrderModel!
    
    // MARK: - Outlets
    //
    @IBOutlet weak var topBackground: UIView!
    @IBOutlet weak var offerStackView: UIStackView!
    @IBOutlet weak var offerProduct: UILabel!
    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var nameProduct: UILabel!
    @IBOutlet weak var priceProduct: UILabel!
    @IBOutlet weak var offerPrice: UILabel!
    @IBOutlet weak var savePrice: UILabel!
    // MARK: - Lifecycle
    //
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureUI()
        
    }
}
// MARK: - Configuration
//
extension CardOfProductCollectionViewCell {
    private func configureUI() {
        topBackground.backgroundColor = Colors.heavyGray
        topBackground.layer.cornerRadius = 10
        topBackground.clipsToBounds = true
        
        offerStackView.backgroundColor = Colors.primaryBlue
        offerStackView.layer.cornerRadius = 10
        offerStackView.clipsToBounds = true
        offerStackView.axis = .vertical
        offerStackView.alignment = .center
        offerStackView.distribution = .equalCentering
        offerStackView.spacing = 3

        imageProduct.contentMode = .scaleAspectFill
        
        offerProduct.textColor = .white
        offerProduct.font = .caption1
        offerProduct.numberOfLines = 2
        
        nameProduct.font = .title3
        
        priceProduct.font = .callout
        offerPrice.font = .body
        
        savePrice.font = .footnote
        savePrice.textColor = .primaryGreen
    }
    /// Configure the product Details
    ///
    ///  - Parameter product: The `product` containing the data to be displayed in `whishlist` page
    func configureProduct(with product: WishlistItem) {
        self.product = product
    }
    /// Configure the order Details
    ///
    ///  - Parameter order: The `order` containing the data to be displayed in `orders` page
    ///
    func configureOrder(with order: OrderModel) {
        self.order = order
    }
}
// MARK: - Actions
//
extension CardOfProductCollectionViewCell {
    
    /// add to Wishlist
    @IBAction func addToWishlist(_ sender: Any) {
        updateWhishlistItems()
    }
    /// add to Cart
    @IBAction func addToCart(_ sender: UIButton) {
        updataCartItems()
    }
}
// MARK: - Handlers
//
extension CardOfProductCollectionViewCell {
    
    private func updateWhishlistItems() {
        if !CustomeTabBarViewModel.shared.Wishlist.contains(where: { $0 == self.product }) {
            CustomeTabBarViewModel.shared.Wishlist.append(product)
        }
    }
    
    private func updataCartItems() {
        if !CustomeTabBarViewModel.shared.orders.contains(where: { $0 == self.order }) {
            CustomeTabBarViewModel.shared.orders.append(order)
        }
    }
}
