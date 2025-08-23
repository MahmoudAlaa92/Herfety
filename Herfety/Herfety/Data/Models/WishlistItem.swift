//
//  Wishlist.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 01/05/2025.
//

import Foundation

struct WishlistItem: Codable, Equatable {
    let userID, productID: Int?
    let vendorId: Int?
    let name: String?
    var qty: Int?
    let price: Double?
    let offerPrice: Double?
    let offerStartDate, offerEndDate: String?
    let categoryID: Int?
    let createdAt, updatedAt: String?
    let isApproved: Int?
    let longDescription, shortDescription, seoDescription: String?
    let thumbImage: String?
    let productType: String?
    
    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case productID = "productId"
        case vendorId
        case name, qty, price, offerPrice, offerStartDate, offerEndDate
        case categoryID = "categoryId"
        case createdAt, updatedAt, isApproved, longDescription, shortDescription, seoDescription, thumbImage, productType
    }
    
    init(
           userID: Int? = nil,
           productID: Int? = nil,
           vendorId: Int? = nil,
           name: String? = nil,
           qty: Int? = nil,
           price: Double? = nil,
           offerPrice: Double? = nil,
           offerStartDate: String? = nil,
           offerEndDate: String? = nil,
           categoryID: Int? = nil,
           createdAt: String? = nil,
           updatedAt: String? = nil,
           isApproved: Int? = nil,
           longDescription: String? = nil,
           shortDescription: String? = nil,
           seoDescription: String? = nil,
           thumbImage: String? = nil,
           productType: String? = nil
       ) {
           self.userID = userID
           self.productID = productID
           self.vendorId = vendorId
           self.name = name
           self.qty = qty
           self.price = price
           self.offerPrice = offerPrice
           self.offerStartDate = offerStartDate
           self.offerEndDate = offerEndDate
           self.categoryID = categoryID
           self.createdAt = createdAt
           self.updatedAt = updatedAt
           self.isApproved = isApproved
           self.longDescription = longDescription
           self.shortDescription = shortDescription
           self.seoDescription = seoDescription
           self.thumbImage = thumbImage
           self.productType = productType
       }
}

struct WishlistMessage: Codable {
    let message: String?
}
