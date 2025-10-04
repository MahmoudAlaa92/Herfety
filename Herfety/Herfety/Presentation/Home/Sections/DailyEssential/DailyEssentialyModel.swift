//
//  DailyEssentialyModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 08/02/2025.
//

import UIKit

struct DailyEssentialyItem {
    let image: UIImage
    let name: String
    let offer: String
    
    init(image: UIImage, name: String, offer: String) {
        self.name = name
        self.offer = offer
        self.image = image
    }
}
