//
//  Productt.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 21/04/2025.
//

import Foundation

// MARK: - ProducttElement
struct Offer: Codable {
    let id: Int?
    let name, slug: String?
    let thumbImage: String?
    let vendorID, categoryID, brandID: Int?
    let qty: Int?
    let shortDescription, longDescription, sku: String?
    let price, offerPrice: Double?
    let offerStartDate, offerEndDate, productType: String?
    let isApproved: Int?
    let seoTitle, seoDescription, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, name, slug, thumbImage
        case vendorID = "vendorId"
        case categoryID = "categoryId"
        case brandID = "brandId"
        case qty, shortDescription, longDescription, sku, price, offerPrice, offerStartDate, offerEndDate, productType, isApproved, seoTitle, seoDescription, createdAt, updatedAt
    }
}
// MARK: - Encode/decode helpers
class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(0)
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
