//
//  AddReviewViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 06/06/2025.
//
import Foundation
import Combine

class AddReviewViewModel {
    
    let reviersItems: [Reviewrr]
    let productId: Int
    private let userId: Int
    private let reviewRemote: ReviewRemoteProtocol
    private var cancellables = Set<AnyCancellable>()
    
    // Outputs
    let reviewSubmissionResult = PassthroughSubject<Result<Reviewrr, Error>, Never>()
    
    init(reviersItems: [Reviewrr],
         productId: Int,
         userId: Int = CustomeTabBarViewModel.shared.userId ?? 1,
         reviewRemote: ReviewRemoteProtocol = ReviewRemote(network: AlamofireNetwork())) {
        self.productId = productId
        self.userId = userId
        self.reviewRemote = reviewRemote
        self.reviersItems = reviersItems
    }
    
    func submitReview(review: String, rating: String) {
        let request = CreateReviewRequest(
            productId: productId,
            userId: userId,
            review: review,
            rating: rating,
            status: 1,
            createdAt: currentISODateString
        )
        
        reviewRemote.createReview(request: request) { [weak self] result in
            self?.reviewSubmissionResult.send(result)
        }
    }
    
    private var currentISODateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter.string(from: Date())
    }
    
    func validateInputs(review: String, rating: String) -> Bool {
        let trimmedReview = review.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedRating = rating.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard
            !trimmedReview.isEmpty,
            !trimmedRating.isEmpty,
            let ratingValue = Int(trimmedRating),
            (1...5).contains(ratingValue)
        else { return false }
        
        return true
    }
}
