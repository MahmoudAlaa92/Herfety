//
//  ReviewerViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 03/03/2025.
//

import UIKit

class ReviewersViewModel {
    // MARK: - Properties
    var reviewersItems: [Reviewrr] = [ ]
    let productId: Int
    
    var didTapPlusButton: (() -> Void)?
    
    // MARK: - Init
    init(productId: Int, reviews: [Reviewrr] = []) {
        self.productId = productId
        self.reviewersItems = reviews
    }

    func didTapPlusButton(navigationController: UINavigationController?) {
        let AddReviewVC = AddReviewViewController(viewModel: AddReviewViewModel(reviersItems: self.reviewersItems, productId: productId))
        navigationController?.pushViewController(AddReviewVC, animated: true)
    }
    
    func fetchReviews() async {
        let remote: ReviewRemoteProtocol = ReviewRemote(network: AlamofireNetwork())
        do {
            let reviews = try await remote.getReviewsAsync(productId: productId)
            self.reviewersItems = reviews
        } catch {
            print("Error fetching reviews: \(error)")
        }
    }
}
