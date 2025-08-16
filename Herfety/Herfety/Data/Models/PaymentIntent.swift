//
//  PaymentIntent.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 18/06/2025.
//

import Foundation

// MARK: - PaymentIntent
struct PaymentIntent: Codable {
    let amount, companyDelivery: Int
    let products: [ProductIntent]
}

// MARK: - ProductIntent
struct ProductIntent: Codable {
    let vendorID, productID, quantity: Int

    enum CodingKeys: String, CodingKey {
        case vendorID = "vendorId"
        case productID = "productId"
        case quantity
    }
}

