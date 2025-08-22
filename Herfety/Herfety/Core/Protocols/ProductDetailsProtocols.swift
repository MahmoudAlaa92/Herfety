//
//  ProductDetailsProtocols.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 21/08/2025.
//

import Combine
import UIKit

// MARK: - Home Module Protocols
//
protocol ProductDetailsDataSourceProtocol {
    func fetchReviews(currentProductId: Int) async throws -> [Reviewrr]
    func fetchRecommended() async throws -> [Products]
}

protocol ProductdDetailsSectionConfiguratorProtocol {
    func configureSection(
        currentProductId: Int,
        coordinator: PoroductsDetailsTransitionDelegate,
        productItems: Wishlist,
        reviewsItems: [Reviewrr],
        recommendItems: [Products]
    ) -> [CollectionViewDataSource]

    func configureLayoutSections() -> [LayoutSectionProvider]
}
