//
//  ButtonCollectionReusableView.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 02/03/2025.
//
import UIKit

class ButtonCollectionReusableView: UICollectionReusableView {
    
    // MARK: - Properties
    static let identifier = "ButtonCollectionReusableView"
    var order: WishlistItem!

    // MARK: - Outlets
    @IBOutlet weak var button: PrimaryButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
// MARK: - Configuration
//
extension ButtonCollectionReusableView {
    func configure(with viewModel: ViewModel) {
        button.setTitle(viewModel.title, for: .normal)
        button.addTarget(viewModel.target, action: viewModel.action, for: .touchUpInside)
    }
    
    /// Configure the order Details
    ///
    ///  - Parameter order: The `order` containing the data to be displayed in `orders` page
    ///
    func configureProduct(with order: WishlistItem) {
        self.order = order
    }
}
// Actions
//
extension ButtonCollectionReusableView {
    @IBAction func addToCart(_ sender: Any) {
        Task {
            let dataStore = DataStore.shared
            let isInCart = await dataStore.isItemInCart(productId: order.productID ?? 92)
            
            if !isInCart {
                var cartItem = await dataStore.getCartItems()
                let countProduct = await dataStore.getCountProductDetails()
                order.qty = countProduct
                cartItem.append(order)
                await dataStore.updateCartItems(cartItem, showAlert: true)
            } else {
                await MainActor.run {
                    AppDataStorePublisher.shared.notifyCartUpdate(showAlert: true)
                }
            }
        }

    }
}
// MARK: - ViewModel
//
extension ButtonCollectionReusableView {
    /// The ViewModel structure for HerfetyCollectionReusableView.
    struct ViewModel {
        let title: String
        let target: Any?
        let action: Selector
    }
}
