//
//  AddAddressViewModelType.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 13/07/2025.
//

import Foundation
import Combine

typealias AddAddressViewModelType = AddAddressViewModelInput & AddAddressViewModelOutput

protocol AddAddressViewModelInput {
    func updateName(_ text: String)
    func updateAddress(_ text: String)
    func updatePhone(_ text: String)
    func addButtonTapped()
}

protocol AddAddressViewModelOutput {
    var isAddButtonEnabled: AnyPublisher<Bool, Never> { get }
    var success: PassthroughSubject<Void, Never> { get }
    var showAlert: PassthroughSubject<AlertModel, Never> { get }
}
