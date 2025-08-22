//
//  ReviewersProtocols.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 22/08/2025.
//

import Foundation

protocol ReviewersDataSourceProtocol {
    func fetchReviews(productId: Int) async throws -> [Reviewrr]
    func deleteReview(review: Reviewrr, at index: Int) async throws -> Bool
    func updateReview(review: Reviewrr, newText: String, productId: Int) async throws -> Reviewrr
}

protocol ReviewersSectionConfiguratorProtocol {
    func configureSections(
        reviewers: [Reviewrr],
        onDelete: @escaping (Int) -> Void,
        onUpdate: @escaping (Int, String) -> Void
    ) -> [CollectionViewDataSource]
    
    func configureLayoutSections() -> [LayoutSectionProvider]
}
