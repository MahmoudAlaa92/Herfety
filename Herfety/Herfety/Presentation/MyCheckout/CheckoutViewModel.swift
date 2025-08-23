//
//  CheckoutViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 13/07/2025.
//

import Foundation
import StripePaymentSheet
import Combine

class CheckoutViewModel {
    // MARK: - Published Properties
    @Published var isCheckoutEnabled: Bool = false
    @Published var isLoading: Bool = false
    @Published var alertItem: AlertModel?
    
    // MARK: - Properties
    private var embeddedPaymentElement: EmbeddedPaymentElement?
    private let paymentIntentRemote: PaymentIntentRemoteProtocol
    private let ordersRemote: OrderRemoteProtocol
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Init
    init(paymentIntentRemote: PaymentIntentRemoteProtocol = PaymentIntentRemote(network: AlamofireNetwork()),
         ordersRemote: OrderRemoteProtocol = GetAllOrdersRemote(network: AlamofireNetwork())) {
        self.paymentIntentRemote = paymentIntentRemote
        self.ordersRemote = ordersRemote
#if DEBUG
        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { [weak self] _ in
            Task { @MainActor in
                self?.embeddedPaymentElement?.testHeightChange()
            }
        }
#endif
    }
    // MARK: - Public Methods
    func createEmbeddedPaymentElement() async throws -> EmbeddedPaymentElement {
        let totalPrice = await DataStore.shared.getTotalPriceOfOrders()
        
        let intentConfig = PaymentSheet.IntentConfiguration(
            mode: .payment(amount: Int(ceil(Double(totalPrice) * 100.0)),
                           currency: "USD")
        ) { [weak self] _, _, intentCreationCallback in
            self?.handleConfirm(intentCreationCallback)
        }
        
        var configuration = EmbeddedPaymentElement.Configuration()
        configuration.returnURL = "herfety://stripe-redirect"
        
        let result = try await EmbeddedPaymentElement.create(
            intentConfiguration: intentConfig,
            configuration: configuration)
        self.embeddedPaymentElement = result
        return result
    }
    
    func confirmPayment() async -> PaymentSheetResult {
        guard let embeddedPaymentElement else { return .canceled }
        
        guard await embeddedPaymentElement.paymentOption != nil else {
            alertItem = AlertModel(
                message: "Please select a payment method",
                buttonTitle: "Ok",
                image: .warning,
                status: .warning
            )
            return .failed(error: NSError(domain: "Checkout", code: 1, userInfo: [NSLocalizedDescriptionKey: "No payment method selected"]))
        }
        isLoading = true
        
        let result = await embeddedPaymentElement.confirm()
        isLoading = false
        
        return result
    }
    
    func handlePaymentResult(_ result: PaymentSheetResult) {
        var alertItem: AlertModel
        
        switch result {
        case .completed:
            alertItem = AlertModel(
                message: "Payment Completed",
                buttonTitle: "Ok",
                image: .success,
                status: .success
            )
            Task {
                await self.createOrder()
            }
            
        case .failed(let error):
            /// Handle the custom error for missing payment method
            if (error as NSError).code == 1 {
                alertItem = AlertModel(
                    message: "Please select a payment method",
                    buttonTitle: "Ok",
                    image: .warning,
                    status: .warning
                )
            } else {
                alertItem = AlertModel(
                    message: "Payment Failed: \(error.localizedDescription)",
                    buttonTitle: "Ok",
                    image: .error,
                    status: .error
                )
            }
            
        case .canceled:
            alertItem = AlertModel(
                message: "Payment Canceled",
                buttonTitle: "Ok",
                image: .warning,
                status: .warning
            )
        }
        self.alertItem = alertItem
    }
    
    func createOrder() async {
        do {
            let cartItems = await DataStore.shared.getCartItems()
            let userId =  await DataStore.shared.getUserId()
            let infos = await DataStore.shared.getInfos()
            let total = await DataStore.shared.getTotalPriceOfOrders()
            
            let products = cartItems.map { item in
                ProductIntent(
                    vendorID: item.vendorId ?? 12,
                    productID: item.productID ?? 93,
                    quantity: item.qty ?? 3
                )
            }
            
            let order = OrderDeliveryItem(
                companyDeliveryId: 1,
                userId: userId,
                currencyName: 0,
                paymentMethod: 0,
                orderAddress: infos[0].address ?? "Egypt Aswan", /// Error here
                subTotal: Double(total),
                orderStatus: 1,
                productsOrder: products,
                createdAt: Date().ISO8601Format(),
                updatedAt: Date().ISO8601Format()
            )
            
            _ = try await ordersRemote.addOrder(order: order)
        } catch {
            self.alertItem = AlertModel(
                message: "Failed to place order: \(error.localizedDescription)",
                buttonTitle: "Ok",
                image: .error,
                status: .error
            )
            
        }
        
    }
    // MARK: - Private Methods
    private func handleConfirm(_ intentCreationCallback: @escaping (Result<String, Error>) -> Void) {
        Task { @MainActor in
            let cartItems = await DataStore.shared.getCartItems()
            let amount = Int(ceil(Double(await DataStore.shared.getTotalPriceOfOrders()) * 100.0))
            
            let products = cartItems.map { item in
                ProductIntent(
                    vendorID: item.vendorId ?? 12,
                    productID: item.productID ?? 93,
                    quantity: item.qty ?? 3
                )
            }
            
            paymentIntentRemote.createPaymentIntent(
                PaymentIntent: .init(
                    amount: amount,
                    companyDelivery: 1,
                    products: products
                )
            ) { result in
                switch result {
                case .success(let response):
                    if let clientSecret = response.clientSecret {
                        intentCreationCallback(.success(clientSecret))
                    } else {
                        let error = NSError(
                            domain: "PaymentError",
                            code: 0,
                            userInfo: [NSLocalizedDescriptionKey: "Client secret missing from response"]
                        )
                        intentCreationCallback(.failure(error))
                    }
                case .failure(let error):
                    intentCreationCallback(.failure(error))
                }
            }
        }
    }
}
