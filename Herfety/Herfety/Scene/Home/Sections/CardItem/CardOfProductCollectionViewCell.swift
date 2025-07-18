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
    var productOfWishlist: Wishlist!
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
        
        nameProduct.font = .callout
        nameProduct.numberOfLines = 2
        nameProduct.lineBreakMode = .byWordWrapping
        
        priceProduct.font = .callout
        offerPrice.font = .body
        
        savePrice.font = .footnote
        savePrice.textColor = .primaryGreen
        /// Add a light strikethrough line to the offerPrice label
        if let offerPriceText = offerPrice.text {
            let attributeString = NSMutableAttributedString(string: offerPriceText)
            /// Apply a single line strikethrough style
            attributeString.addAttribute(
                .strikethroughStyle,
                value: NSUnderlineStyle.single.rawValue,
                range: NSRange(location: 0, length: attributeString.length)
            )
            /// Set the strikethrough color to a light gray
            attributeString.addAttribute(
                .strikethroughColor,
                value: UIColor.lightGray,
                range: NSRange(location: 0, length: attributeString.length)
            )
            /// Apply the attributed string to the label
            offerPrice.attributedText = attributeString
        }
    }
    /// Configure the product Details
    ///
    ///  - Parameter product: The `product` containing the data to be displayed in `Wishlist & Cart` page
    func configureProduct(with product: Wishlist) {
        self.productOfWishlist = product
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
        if !CustomeTabBarViewModel.shared.Wishlist.contains(where: { $0 == self.productOfWishlist }) {
            let productItems: ProductsOfWishlistRemote = ProductsOfWishlistRemote(network: AlamofireNetwork())
            
            productItems.addNewProduct(userId: CustomeTabBarViewModel.shared.userId, productId: (productOfWishlist.productID ?? 1)) { result in
                CustomeTabBarViewModel.shared.fetchWishlistItems(id: CustomeTabBarViewModel.shared.userId)
            }
        }
        CustomeTabBarViewModel.shared.isWishlistItemDeleted.send(false)
    }
    
    private func updataCartItems() {
        if var itemToAdd = productOfWishlist ,
           !CustomeTabBarViewModel.shared.cartItems.contains(where: { $0 == self.productOfWishlist })  {
            itemToAdd.qty = 1
            CustomeTabBarViewModel.shared.cartItems.append(itemToAdd)
            CustomeTabBarViewModel.shared.isOrdersItemDeleted.send(false)
        }
    }
}
