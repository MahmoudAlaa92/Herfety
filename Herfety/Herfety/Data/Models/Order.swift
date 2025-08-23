//
//  Order.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 05/05/2025.
//

import Foundation

struct Order: Codable {
    let userID: Int?
    let userName, currencyName, paymentMethod, createdAt: String?
    let companyDeliveryID: Int
    let orderAddress: String
    let productsOrder: [ProductsOrder]
    let subTotal: Int

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case userName, currencyName, paymentMethod, createdAt
        case companyDeliveryID = "companyDeliveryId"
        case orderAddress, productsOrder, subTotal
    }
}

// MARK: - ProductsOrder
struct ProductsOrder: Codable {
    let productID, quantity: Int

    enum CodingKeys: String, CodingKey {
        case productID = "productId"
        case quantity
    }
}

struct OrderDeliveryItem : Decodable {
    let companyDeliveryId: Int
    let userId: Int
    let currencyName: Int
    let paymentMethod: Int
    let orderAddress: String
    let subTotal: Double
    let orderStatus: Int
    let productsOrder: [ProductIntent]
    let createdAt: String
    let updatedAt: String
}
