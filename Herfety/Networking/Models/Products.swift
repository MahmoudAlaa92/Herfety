//
//  Products.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 23/04/2025.
//
import Foundation

// MARK: - Product
struct Products: Codable, Equatable {
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
    init(
           id: Int? = nil,
           name: String? = nil,
           slug: String? = nil,
           thumbImage: String? = nil,
           vendorID: Int? = nil,
           categoryID: Int? = nil,
           brandID: Int? = nil,
           qty: Int? = nil,
           shortDescription: String? = nil,
           longDescription: String? = nil,
           sku: String? = nil,
           price: Double? = nil,
           offerPrice: Double? = nil,
           offerStartDate: String? = nil,
           offerEndDate: String? = nil,
           productType: String? = nil,
           isApproved: Int? = nil,
           seoTitle: String? = nil,
           seoDescription: String? = nil,
           createdAt: String? = nil,
           updatedAt: String? = nil,
       ) {
           self.id = id
           self.name = name
           self.slug = slug
           self.thumbImage = thumbImage
           self.vendorID = vendorID
           self.categoryID = categoryID
           self.brandID = brandID
           self.qty = qty
           self.shortDescription = shortDescription
           self.longDescription = longDescription
           self.sku = sku
           self.price = price
           self.offerPrice = offerPrice
           self.offerStartDate = offerStartDate
           self.offerEndDate = offerEndDate
           self.productType = productType
           self.isApproved = isApproved
           self.seoTitle = seoTitle
           self.seoDescription = seoDescription
           self.createdAt = createdAt
           self.updatedAt = updatedAt
       }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
            return nil
    }

    required init?(stringValue: String) {
            key = stringValue
    }

    var intValue: Int? {
            return nil
    }

    var stringValue: String {
            return key
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
