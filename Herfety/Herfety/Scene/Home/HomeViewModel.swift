//
//  HomeViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 04/02/2025.
//

import UIKit
import Combine

@MainActor
class HomeViewModel {
    // MARK: - Properties
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
    @Published private(set) var sections: [CollectionViewDataSource] = []
    @Published private(set) var layoutSections: [LayoutSectionProvider] = []
    ///
    private let dataStore = DataStore.shared
    private let publisherManager = AppDataStorePublisher.shared
    ///
    weak var coordinator: HomeTranisitionDelegate?
    private var cancellabels = Set<AnyCancellable>()
    // MARK: - Init
    init(coordinator: HomeTranisitionDelegate) {
        self.coordinator = coordinator
        
        configureSections()
        configureLayoutSections()
        observeWishlist()
        observeOrders()
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
// MARK: - Configuration
//
extension HomeViewModel {
    private func configureSections() {
        let sliderProvider = SliderCollectionViewSection(sliderItems: sliderItems)
        sliderProvider
            .selectedItem
            .sink { [weak self] sliderItems in
                self?.coordinator?.goToSliderItem(discount: (sliderItems.1+1)*10)
            }
            .store(in: &cancellabels)
        
        let categoryProvider = CategoryCollectionViewSection(categoryItems: categoryItems)
        categoryProvider
            .categorySelection
            .sink { [weak self] item in
                self?.coordinator?.goToCategoryItem(category: item.name ?? "")
            }
            .store(in: &cancellabels)
        
        let cardProvider = CardItemCollectionViewSection(productItems: productItems)
        cardProvider.headerConfigurator = { header in
            header.configure(title: "the best deal on", description: "Jewelry & Accessories", shouldShowButton: true)}
        cardProvider
            .selectedItem
            .sink(receiveValue: { [weak self] value in
                self?.coordinator?.gotToBestDealItem(productDetails: value)
            })
            .store(in: &cancellabels)
        
        let topBrands = TopBrandsCollectionViewSection(topBrandsItems: topBrandsItems)
        topBrands
            .selectedBrand
            .sink(receiveValue: { [weak self] items in
                self?.coordinator?.gotToTopBrandItem(discount: (items.1+5)*10)
            })
            .store(in: &cancellabels)
        
        let dailyEssentials = DailyEssentailCollectionViewSection(dailyEssentail: dailyEssentailItems)
        dailyEssentials
            .selectedItem
            .sink(receiveValue: { [weak self] items in
                self?.coordinator?.gotToDailyEssentialItem(discount: (items.1+5)*10)
            })
            .store(in: &cancellabels)
        
        sections = [sliderProvider ,categoryProvider ,cardProvider ,topBrands ,dailyEssentials]
    }
    private func configureLayoutSections() {
        layoutSections = [
            SliderSectionLayoutProvider(),
            CategoriesSectionLayoutSection(),
            CardProductSectionLayoutProvider(),
            TopBrandsSectionLayoutProvider(),
            DailyEssentailSectionLayoutProvider()
        ]
    }
}
// MARK: - Private Handler
//
@MainActor
extension HomeViewModel {
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
            .store(in: &cancellabels)
    }
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
            }
            .store(in: &cancellabels)
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
             configureSections()
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
            configureSections()
        } catch {
            print("Error when fetching best deal on: \(error)")
        }
    }
}
