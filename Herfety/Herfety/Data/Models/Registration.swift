//
//  Registration.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 09/05/2025.
//

import Foundation

struct Registration: Codable {
    let id: Int?
    let message: String?
    let userName: String?
    let email: String?
    let token: String?
    let isAuthenticated: Bool?
    let roles: [String]?
    let expiresOn: String?
}

