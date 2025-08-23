//
//  ProductDetailsDataSource.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 21/08/2025.
//

import Foundation

class ProductDetailsDataSource: ProductDetailsDataSourceProtocol {
    
    let reviewsRemote: ReviewRemoteProtocol
    let recommendedProdcutsRemote: ProductsRemoteProtocol
    
    init(reviewsRemote: ReviewRemoteProtocol,
         recommendedProdcutsRemote: ProductsRemoteProtocol) {
        self.reviewsRemote = reviewsRemote
        self.recommendedProdcutsRemote = recommendedProdcutsRemote
    }
    
    func fetchReviews(currentProductId: Int) async throws -> [ReviewrItem] {
        return try await reviewsRemote.getReviewsAsync(productId: currentProductId)
    }
    
    func fetchRecommended() async throws -> [Products] {
        return try await recommendedProdcutsRemote.loadAllProducts()
    }
}
