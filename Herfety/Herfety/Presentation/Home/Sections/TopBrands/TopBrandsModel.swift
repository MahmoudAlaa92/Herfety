//
//  TopBrands.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 09/02/2025.
//

import UIKit

struct TopBrandsItem {
    let name: String
    let image: UIImage
    let logo: UIImage
    let background: UIImage
    let offer: String
    let color: UIColor
    
    init(name: String, image: UIImage, logo: UIImage, offer: String, background: UIImage, color: UIColor) {
        self.name = name
        self.offer = offer
        self.image = image
        self.logo = logo
        self.background = background
        self.color = color
    }
}
