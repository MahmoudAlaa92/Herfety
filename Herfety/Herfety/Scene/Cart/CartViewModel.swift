//
//  OrderViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 11/02/2025.
//
import UIKit
import Combine

class CartViewModel: ObservableObject {
    // MARK: - Properties
    @Published var orderItems: [Wishlist] = []
    @Published private(set) var paymentInfo: PaymentView.Model = PaymentView.Model(subTotal: 0, shipping: 0, total: 0, numberOfItems: 0)
    @Published var orderAlert: AlertModel?
    
    var navigationToShipping: (() -> Void)?
    ///
    private var subscriptions = Set<AnyCancellable>()
    // MARK: - Init
    init() {
        observeOrderUpdates()
        observeOrderItems()
    }
    func didTapPayment() {
        if orderItems.isEmpty {
            self.orderAlert = AlertModel(
                message: "Order is empty, please add some products",
                buttonTitle: "Ok",
                image: .warning,
                status: .warning)
        } else {
            navigationToShipping?()
        }
    }
    func updateOrderCount(at index: Int, to newCount: Int) {
        guard orderItems.indices.contains(index) else { return }
            orderItems[index].qty = newCount
            // TODO: when increase the alert showed, solve this logic here
         // CustomeTabBarViewModel.shared.orders = orderItems
    }
}
// MARK: - Private Handlers
//
extension CartViewModel {
    private func observeOrderUpdates() {
        CustomeTabBarViewModel
            .shared
            .$cartItems
            .receive(on: DispatchQueue.main)
            .assign(to: &$orderItems)
    }

    private func observeOrderItems() {
        $orderItems
            .map { orderItems -> PaymentView.Model in
                let subTotal = orderItems.reduce(0.0) {
                    let price = $1.price ?? 0.0
                    let quantity = Double($1.qty ?? 0)
                    return $0 + (price * quantity)
                }
                let shipping: Double = subTotal > 0 ? 10.0 : 0.0
                let total = subTotal + shipping
                let numberOfItems = orderItems.reduce(0) { $0 + ($1.qty ?? 0) }
                
                // TODO: change this logic
                let roundedTotal = total == floor(total) ? total : ceil(total)
                         CustomeTabBarViewModel.shared.totalPriceOfOrders = Int(roundedTotal)
                return PaymentView.Model(
                    subTotal: subTotal,
                    shipping: shipping,
                    total: total,
                    numberOfItems: numberOfItems
                )
            }
            .receive(on: DispatchQueue.main)
            .assign(to: &$paymentInfo)
    }
    
    func deleteItem(at index: Int) {
        guard orderItems.indices.contains(index) else { return }
        var updatedItems = orderItems
        updatedItems.remove(at: index)
        orderItems = updatedItems
        
        CustomeTabBarViewModel.shared.isOrdersItemDeleted.send(true)
        CustomeTabBarViewModel.shared.cartItems = updatedItems
    }

}
