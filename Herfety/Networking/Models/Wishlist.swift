//
//  Wishlist.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 01/05/2025.
//

import Foundation

struct Wishlist: Codable, Equatable {
    let userID, productID: Int?
    let name: String?
    let qty: Int?
    let price: Double?
    let offerPrice: Int?
    let offerStartDate, offerEndDate: String
    let brandID: Int?
    let categoryID: Int?
    let couponID: Int?
    let createdAt, updatedAt: String?
    let isApproved: Int?
    let longDescription, shortDescription, seoDescription: String?
    let thumbImage: String?
    let productType: String?

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case productID = "productId"
        case name, qty, price, offerPrice, offerStartDate, offerEndDate
        case brandID = "brandId"
        case categoryID = "categoryId"
        case couponID = "couponId"
        case createdAt, updatedAt, isApproved, longDescription, shortDescription, seoDescription, thumbImage, productType
    }
}
