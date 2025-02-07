//
//  HomeModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 04/02/2025.
//

import UIKit

struct SliderItem {
    let name: String
    let description: String
    let offer: String
    let image: UIImage
}

struct CategryItem {
    let name: String
    let image: UIImage
}

struct ProductItem {
    let name: String
    let price: String
    let offer: String
    let save: String
}

struct TopBrandsItem {
    
}

struct DailyEssentailItem {
    let name: String
    let offer: String
}

enum HomeSection: Int, CaseIterable {
    case slider
    case categories
    case products
    case dailyEssentials
}
