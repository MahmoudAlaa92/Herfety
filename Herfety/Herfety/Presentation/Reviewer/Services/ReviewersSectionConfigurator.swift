//
//  ReviewersSectionConfigurator.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 22/08/2025.
//

import Foundation

final class ReviewersSectionConfigurator: ReviewersSectionConfiguratorProtocol {
    
    func configureSections(
        reviewers: [ReviewrItem],
        onDelete: @escaping (Int) -> Void,
        onUpdate: @escaping (Int, String) -> Void
    ) -> [CollectionViewDataSource] {
        
        let section = createReviewersSection(
            reviewers: reviewers,
            onDelete: onDelete,
            onUpdate: onUpdate
        )
        
        return [section]
    }
    
    func configureLayoutSections() -> [LayoutSectionProvider] {
        return [ReviewerCollectionViewLayoutSection()]
    }
}

// MARK: - Private Section Creators
extension ReviewersSectionConfigurator {
    private func createReviewersSection(
        reviewers: [ReviewrItem],
        onDelete: @escaping (Int) -> Void,
        onUpdate: @escaping (Int, String) -> Void
    ) -> ReviewerCollectionViewSection {
        
        let section = ReviewerCollectionViewSection(reviewers: reviewers)
        section.onDelete = onDelete
        section.onUpdate = onUpdate
        
        return section
    }
}
