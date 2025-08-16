//
//  TopBrands.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 09/02/2025.
//

import UIKit

struct TopBrandsItem: Codable {
    let name: String
    let imageName: String    /// Codable safe
    let logoName: String     /// Codable safe
    let offer: String
    
    /// Computed properties for UIImage
    var image: UIImage? {
        UIImage(named: imageName)
    }
    
    var logo: UIImage? {
        UIImage(named: logoName)
    }
    
    // MARK: - Initializers
    
    /// Use UIImage directly for both image and logo
    init(name: String, image: UIImage, logo: UIImage, offer: String) {
        self.name = name
        self.offer = offer
        self.imageName = image.accessibilityIdentifier ?? ""
        self.logoName = logo.accessibilityIdentifier ?? ""
    }
    
    /// Use String names directly (Codable safe)
    init(name: String, imageName: String, logoName: String, offer: String) {
        self.name = name
        self.offer = offer
        self.imageName = imageName
        self.logoName = logoName
    }
}
