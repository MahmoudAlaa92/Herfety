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
    let backgroundName: String
    let offer: String
    let colorHex: String
    
    /// Computed properties
    var image: UIImage? {
        UIImage(named: imageName)
    }
    
    var logo: UIImage? {
        UIImage(named: logoName)
    }
    
    var backgroundImage: UIImage? {
        UIImage(named: backgroundName)
    }
    
    var color: UIColor {
        UIColor(hex: colorHex) ?? .clear
    }
    
    // MARK: - Initializers
    
    /// Use UIImage directly for both image and logo
    init(name: String, image: UIImage, logo: UIImage, backgroundImage: UIImage, offer: String, color: UIColor) {
        self.name = name
        self.offer = offer
        self.imageName = image.accessibilityIdentifier ?? ""
        self.logoName = logo.accessibilityIdentifier ?? ""
        self.backgroundName = backgroundImage.accessibilityIdentifier ?? ""
        self.colorHex = color.toHex ?? "#000000"
    }
    
    /// Use String names directly (Codable safe)
    init(name: String, imageName: String, logoName: String, offer: String, background: String, colorHex: String) {
        self.name = name
        self.offer = offer
        self.imageName = imageName
        self.logoName = logoName
        self.backgroundName = background
        self.colorHex = colorHex
    }
}
