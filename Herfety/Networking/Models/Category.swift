//
//  Category.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 23/04/2025.
//

import Foundation

// MARK: - CategoryElement
struct CategoryElement: Codable {
    let id: Int?
    let name, slug: String?
    let icon: String?
    let status: Int?
    let createdAt, updatedAt: String?
}
