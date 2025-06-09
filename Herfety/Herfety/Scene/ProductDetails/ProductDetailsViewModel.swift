//
//  ProductDetailsViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 27/02/2025.
//

import Foundation
import Combine

class ProductDetailsViewModel {
    
    @Published var productItem: Wishlist = Wishlist()
    @Published  var recommendItems: [Products] = []
    
    private let reviewRemote: ReviewRemoteProtocol
    private(set) var currentProductId: Int
    
    var reviews: [Reviewrr] = [] {
        didSet {
            onReviewsUpdated?()
        }
    }
    
    // Callbacks
    var onReviewsUpdated: (() -> Void)?
    var onError: ((String) -> Void)?
    
    init(reviewRemote: ReviewRemoteProtocol = ReviewRemote(network: AlamofireNetwork()),
         productId: Int) {
        self.reviewRemote = reviewRemote
        self.currentProductId = productId
        loadReviews()
    }
    
    func loadReviews() {
        reviewRemote.getReviews(productId: currentProductId) { [weak self] result in
            switch result {
            case .success(let reviews):
                self?.reviews = reviews
            case .failure(let error):
                self?.onError?(error.localizedDescription)
            }
        }
    }
    
    func submitReview(review: CreateReviewRequest) {
        reviewRemote.createReview(request: review) { [weak self] result in
            switch result {
            case .success:
                self?.loadReviews()
            case .failure(let error):
                self?.onError?(error.localizedDescription)
            }
        }
    }
    
    func updateReview(id: Int, updatedReview: UpdateReviewRequest) {
        reviewRemote.updateReview(id: id, request: updatedReview) { [weak self] result in
            switch result {
            case .success:
                self?.loadReviews()
            case .failure(let error):
                self?.onError?(error.localizedDescription)
            }
        }
    }
    
    func deleteReview(id: Int) {
        reviewRemote.deleteReview(id: id) { [weak self] result in
            switch result {
            case .success:
                self?.loadReviews()
            case .failure(let error):
                self?.onError?(error.localizedDescription)
            }
        }
    }
}
// MARK: - Handlers
extension ProductDetailsViewModel {
    func fetchProductItems() {
        let ProductsRemote: ProductsRemoteProtocol = ProductsRemote(network: AlamofireNetwork())
        ProductsRemote.loadAllProducts { [weak self] result in
            switch result {
            case .success(let Products):
                DispatchQueue.main.async {
                    self?.recommendItems = Products
                }
            case .failure(let error):
                assertionFailure("Error when fetching categories: \(error)")
            }
        }
    }
}
