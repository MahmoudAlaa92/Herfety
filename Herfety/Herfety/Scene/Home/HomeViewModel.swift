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
        CategryItem(name: "Offers", image: Images.offers),
        CategryItem(name: "Home Décor", image: Images.homeDecore),
        CategryItem(name: "Fashion & Textiles", image: Images.fashion),
        CategryItem(name: "Jewelry", image: Images.jewelry),
        CategryItem(name: "Jewelry", image: Images.jewelry),
        CategryItem(name: "Jewelry", image: Images.jewelry),
        CategryItem(name: "Jewelry", image: Images.jewelry),
    ]
    
    var productItems: [ProductItem] = [
        ProductItem(name: "Jewelry", image: Images.chain, price: "$10499", discountPrice: "$14999", offerPrice: "30%", savePrice: "Save - $4500"),
        ProductItem(name: "Jewelry", image: Images.chain, price: "$10499", discountPrice: "$14999", offerPrice: "30%", savePrice: "Save - $4500"),
        ProductItem(name: "Jewelry", image: Images.chain, price: "$10499", discountPrice: "$14999", offerPrice: "30%", savePrice: "Save - $4500"),
        ProductItem(name: "Jewelry", image: Images.chain, price: "$10499", discountPrice: "$14999", offerPrice: "30%", savePrice: "Save - $4500"),
        ProductItem(name: "Jewelry", image: Images.chain, price: "$10499", discountPrice: "$14999", offerPrice: "30%", savePrice: "Save - $4500"),

    ]
    
    var topBrandsItems: [TopBrandsItems] = [
        TopBrandsItems(name: "Art Fire", image: Images.artLogo, logo: Images.imageOfArt, offer: "UP to 50% OFF"),
        TopBrandsItems(name: "Art Fire", image: Images.artLogo, logo: Images.imageOfArt, offer: "UP to 50% OFF"),
        TopBrandsItems(name: "Art Fire", image: Images.artLogo, logo: Images.imageOfArt, offer: "UP to 50% OFF"),
        TopBrandsItems(name: "Art Fire", image: Images.artLogo, logo: Images.imageOfArt, offer: "UP to 50% OFF"),
    ]
    
    var dailyEssentailItems: [DailyEssentialyItem] = [
        DailyEssentialyItem(image: Images.homeDecore, name: "Home Décor ", offer: "UP to 50% OFF"),
        DailyEssentialyItem(image: Images.art, name: "Art & Collectibles ", offer: "UP to 30% OFF"),
        DailyEssentialyItem(image: Images.craft, name: "Kids’ Crafts & Toys ", offer: "UP to 10% OFF"),
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
