//
//  AddReviewViewModelType.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 19/07/2025.
//

import Foundation
import Combine

typealias AddReviewViewModelType = AddReviewViewModelInput & AddReviewViewModelOutput

protocol AddReviewViewModelInput {
    func updateReviewText(_ text: String)
    func updateRating(_ rating: String)
    func addButtontapped()
}

protocol AddReviewViewModelOutput {
    var isAddButtonEnabled: AnyPublisher<Bool, Never> { get }
    var isSuccess: PassthroughSubject<Void, Never> { get }
    var showAlert: PassthroughSubject<AlertModel, Never> { get }
}
