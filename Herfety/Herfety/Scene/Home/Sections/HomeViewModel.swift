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
        .init(name: "Wear Art, Wear You", description: "Discover Unique Handmade Treasures for Your Journey!", offer: "UP to 10% OFF", image: Images.sliderImage1),
        .init(name: "Own Style, Own Story", description: "Discover Unique Handmade Treasures for Your Journey!", offer: "UP to 20% OFF", image: Images.chain),
        .init(name: "Dress Bold, Live True", description: "Discover Unique Handmade Treasures for Your Journey!", offer: "UP to 30% OFF", image: Images.imageOfArt),
        .init(name: "Be Unique, Be You", description: "Discover Unique Handmade Treasures for Your Journey!", offer: "UP to 40% OFF", image: Images.jewelry)
    ]
    
    @Published var categoryItems: [CategoryElement] = []
    @Published var productItems: [Products] = []
    
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

// MARK: - Fetching
//
extension HomeViewModel {
    func fetchCategoryItems() {
        let catergoryRemote: CategoryRemoteProtocol = CategoryRemote(network: AlamofireNetwork())
        catergoryRemote.loadAllCategories { [weak self] result in
            switch result {
            case .success(let categories):
                DispatchQueue.main.async {
                    self?.categoryItems = categories
                }
            case .failure(let error):
                assertionFailure("Error when fetching categories: \(error)")
            }
        }
    }
    
    func fetchProductItems() {
        let ProductsRemote: ProductsRemoteProtocol = ProductsRemote(network: AlamofireNetwork())
        ProductsRemote.loadAllProducts { [weak self] result in
            switch result {
            case .success(let Products):
                DispatchQueue.main.async {
                    self?.productItems = Products
                }
            case .failure(let error):
                assertionFailure("Error when fetching categories: \(error)")
            }
        }
    }
}
