//
//  ProductDetailsSectionConfigurator.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 22/08/2025.
//

import Combine
import Foundation

class ProductDetailsSectionConfigurator: ProductdDetailsSectionConfiguratorProtocol {
    private var cancellables = Set<AnyCancellable>()
    
    func configureSection(
        currentProductId: Int,
        coordinator: PoroductsDetailsTransitionDelegate,
        productItems: Wishlist,
        reviewsItems: [Reviewrr],
        recommendItems: [Products]
    ) -> [CollectionViewDataSource] {
        
        let productSection = creatProductSection(productItems: productItems)
        let reviewsSection = creatReviewsSection(
            reviewItems: reviewsItems,
            rating: productItems,
            currentProductId: currentProductId,
            coordinator: coordinator
        )
        let recommendSection = creatRecommendedSection(productItems: recommendItems, coordinator: coordinator)
        
        return [productSection, reviewsSection, recommendSection]
    }
    
    func configureLayoutSections() -> [LayoutSectionProvider] {
        return [
            ProductDetailsCollectionViewProvider(),
            ReviewCollectionViewSectionLayout(),
            CardProductSectionLayoutProvider(),
        ]
    }
}
// MARK: - Private Section Creators
//
extension ProductDetailsSectionConfigurator {
    func creatProductSection(productItems: Wishlist) -> ProductDetailsCollectionViewSection {
        
        let provider = ProductDetailsCollectionViewSection(productItems: productItems)
        return provider
    }
    
    func creatReviewsSection(
        reviewItems: [Reviewrr],
        rating: Wishlist,
        currentProductId: Int,
        coordinator: PoroductsDetailsTransitionDelegate
    ) -> ReviewCollectionViewSection {
        
        let provider = ReviewCollectionViewSection(
            reviewItems: reviewItems,
            rating: rating
        )
        provider
            .reviewrsButton
            .sink { reviewrs in
                coordinator.goToReviewersVC(
                    productId: currentProductId,
                    reviewers: reviewrs
                )
            }.store(in: &cancellables)
        
        return provider
    }
    
    func creatRecommendedSection(productItems: [Products], coordinator: PoroductsDetailsTransitionDelegate) -> CardItemCollectionViewSection {
        let provider = CardItemCollectionViewSection(productItems: productItems)
        
        provider.headerConfigurator = { header in
            header.configure(
                title: "Recommended for you",
                description: "",
                shouldShowButton: false
            )
        }
        
        provider
        .selectedItem
        .sink(receiveValue: { value in
            coordinator.goToProductDetailsVC(productDetails: value)
        })
        .store(in: &cancellables)
        
        return provider
    }
}
