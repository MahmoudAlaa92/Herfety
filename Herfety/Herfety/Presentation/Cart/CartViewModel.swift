//
//  OrderViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 11/02/2025.
//
import UIKit
import Combine

@MainActor
final class CartViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published private(set) var sections: [CollectionViewDataSource] = []
    @Published private(set) var layoutProviders: [LayoutSectionProvider] = []
    @Published private(set) var paymentInfo: PaymentView.Model = .init(
        subTotal: 0,
        shipping: 0,
        total: 0,
        numberOfItems: 0
    )
    @Published var orderAlert: AlertModel?
    
    // MARK: - Properties
    let dataStore: DataStoreProtocol
    let appDataStore: PublisherExtensionsProtocol
    var navigationToShipping: (() -> Void)?
    var isShowBackButton: Bool = false
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    init(dataStore: DataStoreProtocol = DataStore.shared,
         appDataStore: PublisherExtensionsProtocol = AppDataStorePublisher.shared) {
        self.dataStore = dataStore
        self.appDataStore = appDataStore
        
        bindCartUpdates()
        layoutProviders.append(OrderSectionLayoutProvider())
    }
}
// MARK: - Public Methods
//
extension CartViewModel {
    
    func didTapPayment() {
        if sections.isEmpty ||
            sections.first?.numberOfItems == 0 {
            orderAlert = AlertModel(
                message: L10n.Cart.Error.emptyOrder,
                buttonTitle: L10n.General.ok,
                image: .warning,
                status: .warning
            )
        } else {
            navigationToShipping?()
            Task {
                await dataStore.updateTotalPriceOfOrders(value: Int(ceil(paymentInfo.total)))
            }
        }
    }
    
    func deleteItem(at index: Int) {
        guard let orderSection = sections.first as? CartCollectionViewSection else { return }
        var items = orderSection.orderItems
        guard items.indices.contains(index) else { return }
        items.remove(at: index)
        updatePaymentInfo(cartItems: items)
        sections = [CartCollectionViewSection(orderItems: items)]
        Task {
            await DataStore.shared.updateCartItems(items, showAlert: false)
        }
    }
    
    /// Update payment info
    func updatePaymentInfo(cartItems: [WishlistItem]) {
        let subTotal = cartItems.reduce(0.0) { $0 + (($1.price ?? 0.0) * Double($1.qty ?? 0)) }
        let shipping: Double = subTotal > 0 ? 10.0 : 0.0
        let total = subTotal + shipping
        let numberOfItems = cartItems.reduce(0) { $0 + ($1.qty ?? 0) }
        self.paymentInfo = PaymentView.Model(
            subTotal: subTotal,
            shipping: shipping,
            total: total,
            numberOfItems: numberOfItems
        )
    }
}
// MARK: - Private Methods
//
private extension CartViewModel {
    func bindCartUpdates() {
        appDataStore
            .cartUpdatePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                Task {
                    let cartItems = await self.dataStore.getCartItems()
                    self.updatePaymentInfo(cartItems: cartItems)
                    let provider = CartCollectionViewSection(orderItems: cartItems)
                    /// Listen to delete & count updates
                    provider
                        .deleteItemSubject
                        .sink { [weak self] index in
                            self?.deleteItem(at: index)
                        }
                        .store(in: &self.cancellables)
                    
                    provider
                        .countUpdateSubject
                        .sink { [weak self] index, newCount in
                            guard let items = self?.sections.first as? CartCollectionViewSection else { return }
                            items.orderItems[index].qty = newCount
                            self?.updatePaymentInfo(cartItems: items.orderItems)
                            self?.sections = [items]
                        }
                        .store(in: &self.cancellables)
                    
                    self.sections = [provider]
                }
            }
            .store(in: &cancellables)
    }
}
