//
//  HomeStaticDataProvider.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 16/08/2025.
//

import Foundation

struct HomeStaticDataProvider {
    static func createSliderItems() -> [SliderItem] {
        return [
            .init(
                name: "Wear Art, Wear You",
                description: "Discover Unique Handmade Treasures for Your Journey!",
                offer: "UP to 10% OFF",
                image: Images.sliderImage1
            ),
            .init(
                name: "Own Style, Own Story",
                description: "Discover Unique Handmade Treasures for Your Journey!",
                offer: "UP to 20% OFF",
                image: Images.chain
            ),
            .init(
                name: "Dress Bold, Live True",
                description: "Discover Unique Handmade Treasures for Your Journey!",
                offer: "UP to 30% OFF",
                image: Images.imageOfArt
            ),
            .init(
                name: "Be Unique, Be You",
                description: "Discover Unique Handmade Treasures for Your Journey!",
                offer: "UP to 40% OFF",
                image: Images.jewelry
            ),
        ]
    }
    
    static func createTopBrandsItems() -> [TopBrandsItem] {
        return [
            .init(name: "Leath", image: Images.artLogo, logo: Images.sliderImage1, offer: "UP to 50% OFF"),
            .init(name: "Rhine", image: Images.tradeLogo, logo: Images.imageOfArt, offer: "UP to 60% OFF"),
            .init(name: "Handmade", image: Images.logo, logo: Images.chain, offer: "UP to 70% OFF"),
            .init(name: "Organ", image: Images.artLogo, logo: Images.imageOfArt2, offer: "UP to 80% OFF"),
        ]
    }
    
    static func createDailyEssentialItems() -> [DailyEssentialyItem] {
        return [
            .init(image: Images.homeDecore, name: "Home Décor ", offer: "UP to 50% OFF"),
            .init(image: Images.art, name: "Art & Collectibles ", offer: "UP to 60% OFF"),
            .init(image: Images.craft, name: "Handmade Materials: crepe", offer: "UP to 70% OFF"),
            .init(image: Images.fashion, name: "Kids' Crafts & Toys ", offer: "UP to 80% OFF"),
        ]
    }
}
