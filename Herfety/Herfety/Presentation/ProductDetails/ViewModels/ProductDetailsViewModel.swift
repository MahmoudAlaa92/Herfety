//
//  ProductDetailsViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 27/02/2025.
//

import Combine

final class ProductDetailsViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var recommendItems: [Products] = []
    @Published var reviews: [Reviewrr] = []
    @Published private(set) var sections: [CollectionViewDataSource] = []
    @Published private(set) var layoutSections: [LayoutSectionProvider] = []
    
    // MARK: - Dependencies
    private let dataSource: ProductDetailsDataSource
    private let sectionConfigurator: ProductdDetailsSectionConfiguratorProtocol
    private weak var coordinator: PoroductsDetailsTransitionDelegate?
    
    private var productItem: Wishlist
    private var currentProductId: Int
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    init(dataSource: ProductDetailsDataSource,
         sectionConfigurator: ProductdDetailsSectionConfiguratorProtocol,
         currentProductId: Int,
         coordinator: PoroductsDetailsTransitionDelegate,
         productItem: Wishlist ) {
        self.dataSource = dataSource
        self.sectionConfigurator = sectionConfigurator
        self.currentProductId = currentProductId
        self.coordinator = coordinator
        self.productItem = productItem
        configureSectionsAndLayouts()
    }
}
// MARK: - Public Methods
//
extension ProductDetailsViewModel {
    func fetchData() async {
        await withTaskGroup(of: Void.self) { group in
            group.addTask { await self.fetchReviewsItems()}
            group.addTask { await self.fetchRecommendedItems()}
        }
    }
}
// MARK: - Private Methods
//
extension ProductDetailsViewModel {
    private func configureSectionsAndLayouts() {
        guard let coordinator = coordinator else { return }
        
        sections = sectionConfigurator.configureSection(
            currentProductId: currentProductId,
            coordinator: coordinator,
            productItems: productItem,
            reviewsItems: reviews,
            recommendItems: recommendItems)
        
        layoutSections = sectionConfigurator.configureLayoutSections()
    }
    
    private func fetchRecommendedItems() async {
        do {
            recommendItems = try await dataSource.fetchRecommended()
            configureSectionsAndLayouts()
        } catch {
            print("Error When fetching Recommended Items in productDetailsViewController")
        }
    }
    
    private func fetchReviewsItems() async {
        do {
            reviews = try await dataSource.fetchReviews(currentProductId: currentProductId)
            configureSectionsAndLayouts()
        } catch {
            print("Error When fetching Reviews Items in productDetailsViewController")
        }
    }
}
