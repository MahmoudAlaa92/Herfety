//
//  ProductModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 27/02/2025.
//

import UIKit

struct Product {
//    var id = UUID()
    let image: [UIImage]
    let name: String
    let price: String
    let review: Double
    let reviewCount: Int
    let availableCount: Int
    
    var description: String {
        """
User research: Understanding user needs, preferences, and behaviors.Design principles: Applying established design guidelines and best practices.
""".replacingOccurrences(of: ".", with: ".\n")
        // swiftlint: disable all
    }
    
}
