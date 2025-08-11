//
//  HomeViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 04/02/2025.
//

import Combine
import UIKit

class HomeViewModel {

    @Published var sliderItems: [SliderItem] = [
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

    @Published var categoryItems: [CategoryElement] = []
    @Published var productItems: [Products] = []

    @Published var topBrandsItems: [TopBrandsItem] = [
        .init(
            name: "Leath",
            image: Images.artLogo,
            logo: Images.sliderImage1,
            offer: "UP to 50% OFF"
        ),
        .init(
            name: "Rhine",
            image: Images.tradeLogo,
            logo: Images.imageOfArt,
            offer: "UP to 60% OFF"
        ),
        .init(
            name: "Handmade",
            image: Images.logo,
            logo: Images.chain,
            offer: "UP to 70% OFF"
        ),
        .init(
            name: "Organ",
            image: Images.artLogo,
            logo: Images.imageOfArt2,
            offer: "UP to 80% OFF"
        ),
    ]

    @Published var dailyEssentailItems: [DailyEssentialyItem] = [
        .init(
            image: Images.homeDecore,
            name: "Home Décor ",
            offer: "UP to 50% OFF"
        ),
        .init(
            image: Images.art,
            name: "Art & Collectibles ",
            offer: "UP to 60% OFF"
        ),
        .init(
            image: Images.craft,
            name: "Handmade Materials: crepe",
            offer: "UP to 70% OFF"
        ),
        .init(
            image: Images.fashion,
            name: "Kids’ Crafts & Toys ",
            offer: "UP to 80% OFF"
        ),
    ]
    @Published var showAlert: AlertModel?
    ///
    // MARK: - Private Properties
    private var subscriptions = Set<AnyCancellable>()
    private let dataStore = DataStore.shared
    private let publisherManager = AppDataStorePublisher.shared

    init() {
        Task {
            await observeWishlist()
            await observeOrders()
        }
    }
    @MainActor
    private func observeWishlist() {
        publisherManager
            .wishlistUpdatePublisher
            .dropFirst(2)
            .sink { [weak self] value in
                guard let self = self else { return }

                self.showAlert = AlertModel(
                    message: value
                        ? "Added To Wishlist" : "Deleted From Wishlist",
                    buttonTitle: "Ok",
                    image: .success,
                    status: .success
                )
            }
            .store(in: &subscriptions)
    }

    @MainActor
    private func observeOrders() {
        publisherManager
            .cartUpdatePublisher
            .sink { [weak self] value in
                guard let self = self else { return }

                Task {
                    let message =
                        value ? "Added To Order" : "Deleted From Order"
                    await MainActor.run {
                        self.showAlert = AlertModel(
                            message: message,
                            buttonTitle: "Ok",
                            image: .success,
                            status: .success
                        )
                    }
                }
            }.store(in: &subscriptions)
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
    func fetchCategoryItems() async {
        let catergoryRemote: CategoryRemoteProtocol = CategoryRemote(
            network: AlamofireNetwork()
        )

        do {
            let result = try await catergoryRemote.loadAllCategories()
            self.categoryItems = result
        } catch {
            print("Error when fetching categories: \(error)")
        }
    }
    // MARK: Products
    func fetchProductItems() async {
        let ProductsRemote: ProductsRemoteProtocol = ProductsRemote(
            network: AlamofireNetwork()
        )

        do {
            let products = try await ProductsRemote.loadAllProducts()
            self.productItems = products
        } catch {
            print("Error when fetching best deal on: \(error)")
        }
    }
}
