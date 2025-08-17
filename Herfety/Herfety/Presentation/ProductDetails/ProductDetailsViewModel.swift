//
//  ProductDetailsViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 27/02/2025.
//

import Combine

final class ProductDetailsViewModel {
    // MARK: - Properties
    @Published var productItem: Wishlist = Wishlist()
    @Published var recommendItems: [Products] = []
    @Published var reviews: [Reviewrr] = []
    
    // MARK: - Collection view sections
    private(set) var sections: [CollectionViewDataSource] = []
    private(set) var layoutSections: [LayoutSectionProvider] = []
    private(set) var productDetailsSection: ProductDetailsCollectionViewSection?
    private(set) var reviewDetailsSection: ReviewCollectionViewSection?
    private(set) var recommendedProductsSection: CardItemCollectionViewSection?
    
    private let reviewRemote: ReviewRemoteProtocol
    private(set) var currentProductId: Int
    private var cancellabels = Set<AnyCancellable>()
    // MARK: - Init
    init(reviewRemote: ReviewRemoteProtocol = ReviewRemote(network: AlamofireNetwork()),
         productId: Int) {
        self.reviewRemote = reviewRemote
        self.currentProductId = productId
        configureSections()
        configureLayoutSections()
        Task {
            await loadReviews()
        }
    }
}
// MARK: - Private Handler
//
 extension ProductDetailsViewModel {
     /// Configure Sections
    func configureSections() {
        let productSection = ProductDetailsCollectionViewSection(productItems: productItem)
        self.productDetailsSection = productSection
        
        let reviewsSection = ReviewCollectionViewSection(reviewItems: reviews, rating: productItem)
        self.reviewDetailsSection = reviewsSection
        
        let recommendSection = CardItemCollectionViewSection(productItems: recommendItems)
        recommendSection.headerConfigurator = { header in
            header.configure(
                title: "Recommended for you",
                description: "",
                shouldShowButton: false
            )
        }
        self.recommendedProductsSection = recommendSection
        sections = [productSection, reviewsSection, recommendSection]
    }
      /// Configure Layout Sections
    func configureLayoutSections() {
        let productImagesLayout = ProductDetailsCollectionViewProvider()
        let reviewLayout = ReviewCollectionViewSectionLayout()
        let recommendLayout = CardProductSectionLayoutProvider()
        
        layoutSections = [productImagesLayout, reviewLayout, recommendLayout]
    }
}
// MARK: - Networking
//
extension ProductDetailsViewModel {
    func loadReviews() async {
        do {
            let result = try await reviewRemote.getReviewsAsync(productId: currentProductId)
            self.reviews = result
        } catch {
            print("Error when load Reviews in productDetailsVC\(error.localizedDescription)")
        }
    }
    func fetchProductItems() async {
        let ProductsRemote: ProductsRemoteProtocol = ProductsRemote(network: AlamofireNetwork())
        
        do {
            let products = try await ProductsRemote.loadAllProducts()
            self.recommendItems = products
        } catch {
            print("Error when fetching recommend products in ProductsdetailsVC \(error)")
        }
    }
}
