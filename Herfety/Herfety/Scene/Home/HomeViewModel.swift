//
//  HomeViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 04/02/2025.
//

import UIKit
import UIHerfety

class HomeViewModel {
    
    var sliderItems: [SliderItem] = [
        SliderItem(name: "Wear Art, Wear You", description: "Discover Unique Handmade Treasures for Your Journey!", offer: "UP to 80% OFF", image: Images.sliderImage1),
        SliderItem(name: "Wear Art, Wear You", description: "Discover Unique Handmade Treasures for Your Journey!", offer: "UP to 80% OFF", image: Images.sliderImage1),
        SliderItem(name: "Wear Art, Wear You", description: "Discover Unique Handmade Treasures for Your Journey!", offer: "UP to 80% OFF", image: Images.sliderImage1),
    ]
    
    var categoryItems: [CategryItem] = [
        CategryItem(name: "Jewelry", image: Images.jewelry),
        CategryItem(name: "Jewelry", image: Images.jewelry),
        CategryItem(name: "Jewelry", image: Images.jewelry),
        CategryItem(name: "Jewelry", image: Images.jewelry),
        CategryItem(name: "Jewelry", image: Images.jewelry),
        CategryItem(name: "Jewelry", image: Images.jewelry),
        CategryItem(name: "Jewelry", image: Images.jewelry),
        CategryItem(name: "Jewelry", image: Images.jewelry),
    ]
    
    var productItems: [ProductItem] = [
        ProductItem(name: "Jewelry", price: "$10499", offer: "$14999", save: "Save - $4500"),
        ProductItem(name: "Jewelry", price: "$10499", offer: "$14999", save: "Save - $4500"),
        ProductItem(name: "Jewelry", price: "$10499", offer: "$14999", save: "Save - $4500"),
    ]
    
    var dailyEssentailItems: [DailyEssentailItem] = [
        DailyEssentailItem(name: "Jewelry ", offer: "UP to 50% OFF"),
        DailyEssentailItem(name: "Jewelry ", offer: "UP to 50% OFF"),
        DailyEssentailItem(name: "Jewelry ", offer: "UP to 50% OFF"),
    ]
    
    func numberOfSections() -> Int {
        return HomeSection.allCases.count
    }
    
    func numberOfItems(in section: Int) -> Int {
        switch HomeSection(rawValue: section) {
        case .slider: return sliderItems.count
        case .categories: return categoryItems.count
        case .products: return productItems.count
        case .dailyEssentials: return dailyEssentailItems.count
        case .none: return 0
        }
    }
    
}
