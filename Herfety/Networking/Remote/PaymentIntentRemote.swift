//
//  PaymentIntentRemote.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 15/06/2025.
//

import Foundation

protocol PaymentIntentRemoteProtocol {
    func createPaymentIntent(PaymentIntent: PaymentIntent, completion: @escaping (Result<CheckoutIntentResponse, Error>) -> Void)
}

class PaymentIntentRemote: Remote, PaymentIntentRemoteProtocol, @unchecked Sendable {
    func createPaymentIntent(PaymentIntent: PaymentIntent, completion: @escaping (Result<CheckoutIntentResponse, Error>) -> Void) {
        
        let parameters: [String: Any] = [
            "amount": PaymentIntent.amount,
            "companyDelivery": PaymentIntent.companyDelivery,
            "products": PaymentIntent.products.map { product in
                [
                    "vendorId": product.vendorID,
                    "productId": product.productID,
                    "quantity": product.quantity
                ]
            }
        ]
        
        let request = HerfetyRequest(
            method: .post,
            path: "api/Orders/Payment",
            parameters: parameters,
            destination: .body)
        
        enqueue(request, completion: completion)
    }
}
