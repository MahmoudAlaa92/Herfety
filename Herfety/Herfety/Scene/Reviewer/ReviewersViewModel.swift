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
    
    func deleteReview(at index: Int, completion: @escaping (Bool) -> Void) {
        let review = reviewersItems[index]
        let remote: ReviewRemoteProtocol = ReviewRemote(network: AlamofireNetwork())
        
        guard let reviewId = review.id, CustomeTabBarViewModel.shared.userId == review.userId else {
            completion(false)
            return
        }
        
        remote.deleteReview(id: reviewId) { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.reviewersItems.remove(at: index)
                    completion(true)
                }
            case .failure(let error):
                print("Failed to delete review: \(error)")
                completion(false)
            }
        }
    }
    
    func updateReview(at index: Int, with newText: String, completion: @escaping (Bool) -> Void) {
        let review = reviewersItems[index]
        
        guard let reviewId = review.id,
              CustomeTabBarViewModel.shared.userId == review.userId else {
            completion(false)
            return
        }
        
        let request = UpdateReviewRequest(
            productId: review.product?.id ?? productId,
            userId: review.userId,
            review: newText,
            rating: review.rating,
            status: review.status,
            createdAt: review.createdAt
        )
        
        let remote: ReviewRemoteProtocol = ReviewRemote(network: AlamofireNetwork())
        remote.updateReview(id: reviewId, request: request) { [weak self] result in
            switch result {
            case .success(let updatedReview):
                DispatchQueue.main.async {
                    var updated = updatedReview
                    if let user = updated.user {
                        updated.userName = user.userName
                        updated.email = user.email
                        updated.image = user.image
                    }
                    self?.reviewersItems[index] = updated
                    completion(true)
                }
            case .failure(let error):
                print("Failed to update review: \(error)")
                completion(false)
            }
        }
    }
    
    
}
