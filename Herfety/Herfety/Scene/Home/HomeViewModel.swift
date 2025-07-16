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
        .init(name: "Leath", image: Images.artLogo, logo: Images.sliderImage1, offer: "UP to 50% OFF"),
        .init(name: "Rhine", image: Images.tradeLogo, logo: Images.imageOfArt, offer: "UP to 60% OFF"),
        .init(name: "Handmade", image: Images.logo, logo: Images.chain, offer: "UP to 70% OFF"),
        .init(name: "Organ", image: Images.artLogo, logo: Images.imageOfArt2, offer: "UP to 80% OFF"),
    ]
    
    @Published var dailyEssentailItems: [DailyEssentialyItem] = [
        .init(image: Images.homeDecore, name: "Home Décor ", offer: "UP to 50% OFF"),
        .init(image: Images.art, name: "Art & Collectibles ", offer: "UP to 60% OFF"),
        .init(image: Images.craft, name: "Handmade Materials: crepe", offer: "UP to 70% OFF"),
        .init(image: Images.fashion, name: "Kids’ Crafts & Toys ", offer: "UP to 80% OFF"),
    ]
    
    @Published var wishlistAlert: AlertModel?
    @Published var orderAlert: AlertModel?
    ///
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        observeWishlist()
        observeOrders()
    }
    
    private func observeWishlist() {
        CustomeTabBarViewModel
            .shared
            .isWishlistItemDeleted
            .dropFirst()
            .sink { [weak self] current in
                guard let self = self else { return }
                
                self.wishlistAlert = AlertModel(
                    message: current ? "Deleted From Wishlist" : "Added To Wishlist",
                    buttonTitle: "Ok",
                    image: .success,
                    status: .success
                )
            }
            .store(in: &subscriptions)
    }
    
    private func observeOrders() {
        CustomeTabBarViewModel.shared.isOrdersItemDeleted
            .dropFirst()
            .sink { [weak self] current in
                guard let self = self else { return }
                
                self.orderAlert = AlertModel(
                    message: current ? "Deleted From Order" : "Added To Order",
                    buttonTitle: "Ok",
                    image: .success,
                    status: .success
                )
            }
            .store(in: &subscriptions)
    }
    
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
    // MARK:  Categories
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
    // TODO: change the Dispatch queue here for UI
    // MARK: Products
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
