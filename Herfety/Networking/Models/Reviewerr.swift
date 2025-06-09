//
//  Review.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 14/05/2025.
//

import Foundation

struct Reviewrr: Codable {
    let id: Int?
    let productId: Int?
    let userId: Int
    let review: String
    let rating: String
    let status: Int
    let createdAt: String
    let updatedAt: String?
    let product: Products?
    let user: User?
}

struct CreateReviewRequest: Codable {
    let productId: Int
    let userId: Int
    let review: String
    let rating: String
    let status: Int
    let createdAt: String
}

struct UpdateReviewRequest: Codable {
    let productId: Int
    let userId: Int
    let review: String
    let rating: String
    let status: Int
    let createdAt: String
}

struct DeleteReviewResponse: Codable {
    let message: String
    let deleteditem: Reviewrr
}

struct User: Codable {
    let id, roleID: Int
    let image, fName, lName, userName: String
    let password, phone, email: String
    let role: JSONNull?
    let carts: JSONNull?

    enum CodingKeys: String, CodingKey {
        case id
        case roleID = "roleId"
        case image, fName, lName, userName, password, phone, email, role, carts
    }
}
