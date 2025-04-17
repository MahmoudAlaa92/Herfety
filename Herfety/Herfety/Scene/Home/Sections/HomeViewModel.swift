//
//  HomeViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 04/02/2025.
//

import UIKit
import Combine

class HomeViewModel {
    
    @Published var sliderItems: [SliderItem] = [
        .init(name: "Wear Art, Wear You", description: "Discover Unique Handmade Treasures for Your Journey!", offer: "UP to 80% OFF", image: Images.sliderImage1),
        .init(name: "Wear Art, Wear You", description: "Discover Unique Handmade Treasures for Your Journey!", offer: "UP to 80% OFF", image: Images.sliderImage1),
        .init(name: "Wear Art, Wear You", description: "Discover Unique Handmade Treasures for Your Journey!", offer: "UP to 80% OFF", image: Images.sliderImage1),
    ]
    
    @Published var categoryItems: [CategryItem] = [
       .init(name: "Jewelry", image: Images.jewelry),
       .init(name: "Offers", image: Images.offers),
       .init(name: "Home Décor", image: Images.homeDecore),
       .init(name: "Fashion & Textiles", image: Images.fashion),
       .init(name: "Jewelry", image: Images.jewelry),
       .init(name: "Jewelry", image: Images.jewelry),
       .init(name: "Jewelry", image: Images.jewelry),
       .init(name: "Jewelry", image: Images.jewelry),
    ]
    
    @Published var productItems: [ProductItem] = [
       .init(name: "Jewelry", image: Images.chain, price: "$10499", discountPrice: "$14999", offerPrice: "30%", savePrice: "Save - $4500"),
       .init(name: "Jewelry", image: Images.chain, price: "$10499", discountPrice: "$14999", offerPrice: "30%", savePrice: "Save - $4500"),
       .init(name: "Jewelry", image: Images.chain, price: "$10499", discountPrice: "$14999", offerPrice: "30%", savePrice: "Save - $4500"),
       .init(name: "Jewelry", image: Images.chain, price: "$10499", discountPrice: "$14999", offerPrice: "30%", savePrice: "Save - $4500"),
       .init(name: "Jewelry", image: Images.chain, price: "$10499", discountPrice: "$14999", offerPrice: "30%", savePrice: "Save - $4500")
    ]
    
    @Published var topBrandsItems: [TopBrandsItem] = [
       .init(name: "Art Fire", image: Images.artLogo, logo: Images.imageOfArt, offer: "UP to 50% OFF"),
       .init(name: "Art Fire", image: Images.artLogo, logo: Images.imageOfArt, offer: "UP to 50% OFF"),
       .init(name: "Art Fire", image: Images.artLogo, logo: Images.imageOfArt, offer: "UP to 50% OFF"),
       .init(name: "Art Fire", image: Images.artLogo, logo: Images.imageOfArt, offer: "UP to 50% OFF"),
    ]
    
    @Published var dailyEssentailItems: [DailyEssentialyItem] = [
       .init(image: Images.homeDecore, name: "Home Décor ", offer: "UP to 50% OFF"),
       .init(image: Images.art, name: "Art & Collectibles ", offer: "UP to 30% OFF"),
       .init(image: Images.craft, name: "Kids’ Crafts & Toys ", offer: "UP to 10% OFF"),
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
