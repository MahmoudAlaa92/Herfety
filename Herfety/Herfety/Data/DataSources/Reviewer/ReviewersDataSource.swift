//
//  ReviewersDataSource.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 22/08/2025.
//

import Foundation

enum ReviewError: Error {
    case unauthorized
}

final class ReviewersDataSource: ReviewersDataSourceProtocol {
    private let reviewsRemote: ReviewRemoteProtocol
    
    init(reviewsRemote: ReviewRemoteProtocol) {
        self.reviewsRemote = reviewsRemote
    }
    
    func fetchReviews(productId: Int) async throws -> [Reviewrr] {
        return try await reviewsRemote.getReviewsAsync(productId: productId)
    }
    
    func deleteReview(review: Reviewrr, at index: Int) async throws -> Bool {
        let userId = await DataStore.shared.getUserId()

        guard let reviewId = review.id,
              userId == review.userId else {
            return false
        }
        
        _ = try await reviewsRemote.deleteReview(id: reviewId)
        return true
    }
    
    func updateReview(review: Reviewrr, newText: String, productId: Int) async throws -> Reviewrr {
        let userId = await DataStore.shared.getUserId()
        
        guard let reviewId = review.id,
              userId == review.userId else {
            throw ReviewError.unauthorized
        }
        
        let request = UpdateReviewRequest(
            productId: review.product?.id ?? productId,
            userId: review.userId,
            review: newText,
            rating: review.rating,
            status: review.status,
            createdAt: review.createdAt
        )
        
        var updatedReview = try await reviewsRemote.updateReview(id: reviewId, request: request)
        
        if let user = updatedReview.user {
            updatedReview.userName = user.userName
            updatedReview.email = user.email
            updatedReview.image = user.image
        }
        
        return updatedReview
    }
}


