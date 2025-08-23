//
//  ReviewersViewModelFactory.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 22/08/2025.
//

import Foundation

final class ReviewersViewModelFactory {
    static func create(
        coordinator: ReviewersTransitionDelegate,
        productId: Int,
        reviews: [ReviewrItem] = []
    ) -> ReviewersViewModel {
        
        let reviewRemote = ReviewRemote(network: AlamofireNetwork())
        let dataSource = ReviewersDataSource(reviewsRemote: reviewRemote)
        let sectionConfigurator = ReviewersSectionConfigurator()
        
        return ReviewersViewModel(
            dataSource: dataSource,
            sectionConfigurator: sectionConfigurator,
            productId: productId,
            coordinator: coordinator,
            reviews: reviews
        )
    }
}
