//
//  OrderViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 11/02/2025.
//
import UIKit
import Combine

class OrderViewModel: ObservableObject {
    // MARK: - Properties
    @Published var orderItems: [OrderModel] = []
    @Published private(set) var paymentInfo: PaymentView.Model = PaymentView.Model(subTotal: 0, shipping: 0, total: 0, numberOfItems: 0)
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
            print("Order is empty show Alert here")
        } else {
            navigationToShipping?()
        }
    }
    func updateOrderCount(at index: Int, to newCount: Int) {
        guard orderItems.indices.contains(index) else { return }
            orderItems[index].numberOfOrders = newCount
            CustomeTabBarViewModel.shared.orders = orderItems
    }
}
// MARK: - Private Handlers
//
extension OrderViewModel {
    private func observeOrderUpdates() {
        CustomeTabBarViewModel
            .shared
            .$orders
            .receive(on: DispatchQueue.main)
            .assign(to: &$orderItems)
    }

    private func observeOrderItems() {
        $orderItems
            .map { orderItems -> PaymentView.Model in
                let subTotal = orderItems.reduce(0.0) { $0 + ($1.price * Double($1.numberOfOrders)) }
                let shipping: Double = subTotal > 0 ? 10.0 : 0.0
                let total = subTotal + shipping
                let numberOfItems = orderItems.reduce(0) { $0 + $1.numberOfOrders }
                return PaymentView.Model(subTotal: subTotal, shipping: shipping, total: total, numberOfItems: numberOfItems)
            }
            .receive(on: DispatchQueue.main)
            .assign(to: &$paymentInfo)
    }
}
