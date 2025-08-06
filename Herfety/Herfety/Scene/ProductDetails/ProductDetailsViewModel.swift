//
//  ProductDetailsViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 27/02/2025.
//

import Foundation
import Combine

class ProductDetailsViewModel {
    // MARK: - Properties
    @Published var productItem: Wishlist = Wishlist()
    @Published var recommendItems: [Products] = []
    @Published var reviews: [Reviewrr] = []
    
    private let reviewRemote: ReviewRemoteProtocol
    private(set) var currentProductId: Int
    
    // MARK: - Init
    init(reviewRemote: ReviewRemoteProtocol = ReviewRemote(network: AlamofireNetwork()),
         productId: Int) {
        self.reviewRemote = reviewRemote
        self.currentProductId = productId
        Task {
           await loadReviews()
        }
    }
    
    func loadReviews() async {
        do {
            let result = try await reviewRemote.getReviewsAsync(productId: currentProductId)
            self.reviews = result
        } catch {
            print("Error when load Reviews in productDetailsVC\(error.localizedDescription)")
        }
    }
}
// MARK: - Handlers
extension ProductDetailsViewModel {
    
    func fetchProductItems() async {
        let ProductsRemote: ProductsRemoteProtocol = ProductsRemote(network: AlamofireNetwork())
        
        do {
            let products = try await ProductsRemote.loadAllProducts()
            self.recommendItems = products
        } catch {
            print("Error when fetching recommend products in ProductsdetailsVC \(error)")
        }
    }
}
