//
//  ReviewRemote.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 14/05/2025.
//

import Foundation

protocol ReviewRemoteProtocol {
    /// Async/await versions
    func getReviewsAsync(productId: Int) async throws -> [ReviewrItem]
    func createReview(request: CreateReviewRequest) async throws -> ReviewrItem
    func updateReview(id: Int, request: UpdateReviewRequest) async throws -> ReviewrItem
    func deleteReview(id: Int) async throws -> DeleteReviewResponse
    /// Legacy callback versions for backward compatibility
    func createReview(request: CreateReviewRequest, completion: @escaping (Result<ReviewrItem, Error>) -> Void)
    func getReviews(productId: Int, completion: @escaping (Result<[ReviewrItem], Error>) -> Void)
    func updateReview(id: Int, request: UpdateReviewRequest, completion: @escaping (Result<ReviewrItem, Error>) -> Void)
    func deleteReview(id: Int, completion: @escaping (Result<DeleteReviewResponse, Error>) -> Void)
}

class ReviewRemote: Remote, ReviewRemoteProtocol, @unchecked Sendable {
    
    func createReview(request: CreateReviewRequest, completion: @escaping (Result<ReviewrItem, Error>) -> Void) {
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
            parameters: parameters,
            destination: .body)
        
        enqueue(request, completion: completion)
    }
    
    func getReviews(productId: Int, completion: @escaping (Result<[ReviewrItem], Error>) -> Void) {
            let request = HerfetyRequest(
                method: .get,
                path: "api/ProductReviews/GetAllRevProduct?id=\(productId)",
                parameters: nil
            )
            
            enqueue(request, completion: completion)
        }
    
    func updateReview(id: Int, request: UpdateReviewRequest, completion: @escaping (Result<ReviewrItem, Error>) -> Void) {
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
            parameters: parameters,
            destination: .body)
        
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
    func getReviewsAsync(productId: Int) async throws -> [ReviewrItem] {
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
    
    func createReview(request: CreateReviewRequest) async throws -> ReviewrItem {
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
            parameters: parameters,
            destination: .body)
        
        return try await enqueue(request)
    }
    
    func updateReview(id: Int, request: UpdateReviewRequest) async throws -> ReviewrItem {
        
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
            parameters: parameters,
            destination: .body)
        
        return try await enqueue(request)
    }
    
    func deleteReview(id: Int) async throws -> DeleteReviewResponse {
        let request = HerfetyRequest(
            method: .delete,
            path: "api/ProductReviews?id=\(id)",
            parameters: nil
        )
        
        return try await enqueue(request)
    }
}
