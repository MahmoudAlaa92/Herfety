//
//  AddReviewViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 06/06/2025.
//
import Foundation
import Combine

class AddReviewViewModel: AddReviewViewModelType {

    // MARK: - Subject
    private let commentSubject = CurrentValueSubject<String, Never>("")
    private let rateSubject = CurrentValueSubject<String, Never>("")
    private let addTappedSubject = PassthroughSubject<Void, Never>()

    // MARK: - Properties
    let reviersItems: [Reviewrr]
    let productId: Int
    private let userId: Int
    private let reviewRemote: ReviewRemoteProtocol
    ///
    private var cancellables = Set<AnyCancellable>()

    // Outputs
    let isAddButtonEnabled: AnyPublisher<Bool, Never>
    let isSuccess = PassthroughSubject<Void, Never>()
    let showAlert = PassthroughSubject<AlertModel, Never>()
    // MARK: - Init
    init(
        reviersItems: [Reviewrr],
        productId: Int,
        userId: Int = CustomeTabBarViewModel.shared.userId,
        reviewRemote: ReviewRemoteProtocol = ReviewRemote(
            network: AlamofireNetwork()
        )
    ) {

        self.productId = productId
        self.userId = userId
        self.reviewRemote = reviewRemote
        self.reviersItems = reviersItems

        isAddButtonEnabled = Publishers.CombineLatest(
            commentSubject,
            rateSubject
        )
        .map { !$0.0.isEmpty && !$0.1.isEmpty }
        .eraseToAnyPublisher()
        
        addTappedSubject
            .sink { [weak self] in
                self?.submitReview()
            }
            .store(in: &cancellables)
    }

    func submitReview() {
        
        if !validateInputs(review: commentSubject.value,
                          rating: rateSubject.value) {
            let alertItem = AlertModel(
                message: "Invalid Input\nPlease enter:\n- Review text\n- Rating between 1-5",
                buttonTitle: "OK",
                image: .error,
                status: .error
            )
            showAlert.send(alertItem)
            return
        }
        
        let request = CreateReviewRequest(
            productId: productId,
            userId: userId,
            review: commentSubject.value,
            rating: rateSubject.value,
            status: 1,
            createdAt: currentISODateString
        )

        reviewRemote.createReview(request: request) { [weak self] result in
            switch result {
            case .success:
                let alertItem = AlertModel(
                    message: "Your review has been added",
                    buttonTitle: "OK",
                    image: .success,
                    status: .success
                )
                self?.showAlert.send(alertItem)
                self?.isSuccess.send()
            case .failure(_):
                let alertItem = AlertModel(
                    message: "Failed to add review. Please try again.",
                    buttonTitle: "OK",
                    image: .error,
                    status: .error
                )
                self?.showAlert.send(alertItem)
            }
        }
    }

    private var currentISODateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter.string(from: Date())
    }

    func validateInputs(review: String, rating: String) -> Bool {
        let trimmedReview = review.trimmingCharacters(
            in: .whitespacesAndNewlines
        )
        let trimmedRating = rating.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard
            !trimmedReview.isEmpty,
            !trimmedRating.isEmpty,
            let ratingValue = Int(trimmedRating),
            (1...5).contains(ratingValue)
        else { return false }

        return true
    }
}
// MARK: - Inputs
//
extension AddReviewViewModel {
    func updateReviewText(_ text: String) {
        commentSubject.send(text)
    }

    func updateRating(_ rating: String) {
        rateSubject.send(rating)
    }

    func addButtontapped() {
        addTappedSubject.send()
    }
}
