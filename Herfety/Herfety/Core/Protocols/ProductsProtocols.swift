//
//  ProductsProtocols.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 17/08/2025.
//

import UIKit
import Combine

// MARK: - Products Module Protocols
//
protocol ProductsDataSourceProtocol {
    func fetchProductsOfCategory(discount: Int) async throws -> [Products]
    func fetchWhileSearch(name: String) async throws -> [Products]
}

protocol ProductsSectionConfiguratorProtocol {
    func configureSections(
        productItems: [Products],
        coordinator: ProductsTransitionDelegate
    ) -> [CollectionViewDataSource]
    
    func configureLayoutSections() -> [LayoutSectionProvider]
}
