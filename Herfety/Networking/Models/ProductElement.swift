//
//  Productt.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 21/04/2025.
//

import Foundation

// MARK: - ProducttElement
struct ProductElement: Codable {
    let id: Int?
    let name: String?
    let thumbImage: String?
    let vendorID, categoryID: Int?
    let brandID, couponID: JSONNull?
    let qty: Int?
    let shortDescription, longDescription: String?
    let sku: JSONNull?
    
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
