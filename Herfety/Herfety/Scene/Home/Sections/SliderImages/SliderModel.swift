//
//  SliderModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 08/02/2025.
//

import UIKit

struct SliderItem: Codable {
    let name: String
    let description: String
    let offer: String
    let imageName: String   /// Codable safe
    
    /// Computed property to get UIImage
    var image: UIImage? {
        UIImage(named: imageName)
    }

    /// Extra initializer so you can pass `UIImage` from `Images`
    init(name: String, description: String, offer: String, image: UIImage) {
        self.name = name
        self.description = description
        self.offer = offer
        self.imageName = image.accessibilityIdentifier ?? "" // fallback
    }

    /// Codable initializer (default generated will be used too)
    init(name: String, description: String, offer: String, imageName: String) {
        self.name = name
        self.description = description
        self.offer = offer
        self.imageName = imageName
    }
}
