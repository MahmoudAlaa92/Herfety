//
//  DailyEssentialyModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 08/02/2025.
//

import UIKit

struct DailyEssentialyItem: Codable {
    let imageName: String   /// Codable safe
    let name: String
    let offer: String
    
    /// Computed property to get UIImage
    var image: UIImage? {
        UIImage(named: imageName)
    }
    
    // MARK: - Initializers
    
    /// Initialize using UIImage (not Codable safe, but useful in app)
    init(image: UIImage, name: String, offer: String) {
        self.name = name
        self.offer = offer
        self.imageName = image.accessibilityIdentifier ?? ""
    }
    
    /// Initialize using String imageName (Codable safe)
    init(imageName: String, name: String, offer: String) {
        self.name = name
        self.offer = offer
        self.imageName = imageName
    }
}
