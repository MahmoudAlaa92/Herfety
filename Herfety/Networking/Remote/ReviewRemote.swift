//
//  ReviewRemote.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 14/05/2025.
//

import Foundation

protocol ReviewRemoteProtocol {
    func createReview(request: CreateReviewRequest, completion: @escaping (Result<Reviewrr, Error>) -> Void)
    func getReviews(productId: Int, completion: @escaping (Result<[Reviewrr], Error>) -> Void)
    func getReviewsAsync(productId: Int) async throws -> [Reviewrr]
    func updateReview(id: Int, request: UpdateReviewRequest, completion: @escaping (Result<Reviewrr, Error>) -> Void)
    func deleteReview(id: Int, completion: @escaping (Result<DeleteReviewResponse, Error>) -> Void)
}

class ReviewRemote: Remote, ReviewRemoteProtocol {
    
    func createReview(request: CreateReviewRequest, completion: @escaping (Result<Reviewrr, Error>) -> Void) {
        let parameters: [String: Any] = [
            "productId": request.productId,
            "userId": request.userId,
            "review": request.review,
            "rating": request.rating,
            "status": request.status,
            "createdAt": request.createdAt
        ]
        
        let request = HerfetyRequest(
            method: .post,
            path: "api/ProductReviews",
            parameters: parameters
        )
        
        enqueue(request, completion: completion)
    }
    func getReviews(productId: Int, completion: @escaping (Result<[Reviewrr], Error>) -> Void) {
            let request = HerfetyRequest(
                method: .get,
                path: "api/ProductReviews/GetAllRevProduct?id=\(productId)",
                parameters: nil
            )
            
            enqueue(request, completion: completion)
        }
    
    func updateReview(id: Int, request: UpdateReviewRequest, completion: @escaping (Result<Reviewrr, Error>) -> Void) {
        let parameters: [String: Any] = [
            "productId": request.productId,
            "userId": request.userId,
            "review": request.review,
            "rating": request.rating,
            "status": request.status,
            "createdAt": request.createdAt
        ]
        
        let request = HerfetyRequest(
            method: .put,
            path: "api/ProductReviews?id=\(id)",
            parameters: parameters
        )
        
        enqueue(request, completion: completion)
    }
    
    func deleteReview(id: Int, completion: @escaping (Result<DeleteReviewResponse, Error>) -> Void) {
        let request = HerfetyRequest(
            method: .delete,
            path: "api/ProductReviews?id=\(id)",
            parameters: nil
        )
        
        enqueue(request, completion: completion)
    }
}

// MARK: - Modern Concurency
//
extension ReviewRemote {
    func getReviewsAsync(productId: Int) async throws -> [Reviewrr] {
        try await withCheckedThrowingContinuation { continuation in
            self.getReviews(productId: productId) { result in
                switch result {
                case .success(let reviews):
                    continuation.resume(returning: reviews)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
