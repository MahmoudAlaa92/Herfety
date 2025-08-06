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
    private let remote: ReviewRemoteProtocol

    var didTapPlusButton: (() -> Void)?
    
    // MARK: - Init
    init(productId: Int, reviews: [Reviewrr] = [] , remote: ReviewRemoteProtocol = ReviewRemote(network: AlamofireNetwork())) {
        self.productId = productId
        self.reviewersItems = reviews
        self.remote = remote
    }
    /// Fetch
    func fetchReviews() async {
        let remote: ReviewRemoteProtocol = ReviewRemote(network: AlamofireNetwork())
        do {
            let reviews = try await remote.getReviewsAsync(productId: productId)
            self.reviewersItems = reviews
            
        } catch {
            print("Error fetching reviews: \(error)")
        }
    }
    /// Delete
    func deletReview(at index: Int) async -> Bool{
        let review = reviewersItems[index]
        
        guard let reviewId = review.id,
              await AppDataStore.shared.userId == review.userId else {
            return false
        }
        
        do {
            _ = try await remote.deleteReview(id: reviewId)
            reviewersItems.remove(at: index)
            return true
        } catch {
            print("❌ Failed to delete review: \(error)")
            return false
        }
    }
    /// Update
    func updateReview(at index: Int, with newText: String) async -> Bool {
        let review = reviewersItems[index]
        
        guard let reviewId = review.id,
              await AppDataStore.shared.userId == review.userId else {
            return false
        }
        
        let request = UpdateReviewRequest(
            productId: review.product?.id ?? productId,
            userId: review.userId,
            review: newText,
            rating: review.rating,
            status: review.status,
            createdAt: review.createdAt
        )
      
        do {
            var updatedReview = try await remote.updateReview(id: reviewId, request: request)
            if let user = updatedReview.user {
                updatedReview.userName = user.userName
                updatedReview.email = user.email
                updatedReview.image = user.image
            }
            
            reviewersItems[index] = updatedReview
            return true
        } catch {
            print("❌ Failed to update review: \(error)")
            return false
        }
    }
}
