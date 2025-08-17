//
//  ProductsSectionConfigurator.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 17/08/2025.
//

import Foundation
import Combine

class ProductsSectionConfigurator: ProductsSectionConfiguratorProtocol {
    private var cancellables = Set<AnyCancellable>()
    
    func configureSections(
        productItems: [Products],
        coordinator: ProductsTransitionDelegate
    ) -> [CollectionViewDataSource] {
        let cardProvider = createCardSection(items: productItems, coordinator: coordinator)
        return [cardProvider]
    }
    
    func configureLayoutSections() -> [LayoutSectionProvider] {
        return [ProductsCollectionViewSectionLayout()]
    }
}
// MARK: - Private Section Creators
//
extension ProductsSectionConfigurator {
    func createCardSection(items: [Products], coordinator: ProductsTransitionDelegate) -> ProductsCollectionViewSection {
        let provider = ProductsCollectionViewSection(Products: items)
        provider
            .selectedItem
            .sink { product in
                coordinator.goToProductDetails(productDetails: product)
            }
            .store(in: &cancellables)
        return provider
    }
    
}
