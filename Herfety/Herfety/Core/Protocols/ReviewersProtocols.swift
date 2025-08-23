//
//  ReviewersProtocols.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 22/08/2025.
//

import Foundation

protocol ReviewersDataSourceProtocol {
    func fetchReviews(productId: Int) async throws -> [ReviewrItem]
    func deleteReview(review: ReviewrItem, at index: Int) async throws -> Bool
    func updateReview(review: ReviewrItem, newText: String, productId: Int) async throws -> ReviewrItem
}

protocol ReviewersSectionConfiguratorProtocol {
    func configureSections(
        reviewers: [ReviewrItem],
        onDelete: @escaping (Int) -> Void,
        onUpdate: @escaping (Int, String) -> Void
    ) -> [CollectionViewDataSource]
    
    func configureLayoutSections() -> [LayoutSectionProvider]
}
