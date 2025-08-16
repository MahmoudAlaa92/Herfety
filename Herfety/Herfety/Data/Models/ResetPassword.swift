//
//  ResetPassword.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 14/05/2025.
//

import Foundation

struct ResetPassword: Codable {
    let UserName: String
    let CurrentPassword: String
    let NewPassword: String
    let ConfirmPassword: String
}

struct ResponseReset: Codable {
    let message: String?
}
