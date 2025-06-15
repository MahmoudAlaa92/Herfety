//
//  PaymentIntentRemote.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 15/06/2025.
//

import Foundation

protocol PaymentIntentRemoteProtocol {
    func createPaymentIntent(amount: Int, completion: @escaping (Result<CheckoutIntentResponse, Error>) -> Void)
}

class PaymentIntentRemote: Remote, PaymentIntentRemoteProtocol {
    func createPaymentIntent(amount: Int, completion: @escaping (Result<CheckoutIntentResponse, Error>) -> Void) {
        
        let parameters = ["amount": amount]
        
        let request = HerfetyRequest(
            method: .post,
            path: "api/Orders/Payment",
            parameters: parameters)

        enqueue(request, completion: completion)
    }
}
