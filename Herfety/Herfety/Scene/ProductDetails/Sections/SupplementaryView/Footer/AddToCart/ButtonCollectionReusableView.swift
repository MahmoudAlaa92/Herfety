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
    var order: Wishlist!

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
    func configureProduct(with order: Wishlist) {
        self.order = order
    }
}
// Actions
//
extension ButtonCollectionReusableView {
    @IBAction func addToCart(_ sender: Any) {
        
        if var orderItem = order,
           !CustomeTabBarViewModel.shared.cartItems.contains(where: { $0 == self.order }) {
            orderItem.qty = CustomeTabBarViewModel.shared.countProductDetails
            CustomeTabBarViewModel.shared.cartItems.append(orderItem)
            CustomeTabBarViewModel.shared.isOrdersItemDeleted.send(false)
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
