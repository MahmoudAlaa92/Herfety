//
//  SignupViewModelType.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 03/07/2025.
//

import Combine

typealias SignupViewModelType = SignupViewModelInput & SignupViewModelOutput

// MARK: - ViewModel Input
//
protocol SignupViewModelInput {
    func updateFirstName(_ text: String)
    func updateLastName(_ text: String)
    func updateUsername(_ text: String)
    func updateEmail(_ text: String)
    func updatePassword(_ text: String)
    func updateConfirmPassword(_ text: String)
    func updatePhone(_ text: String)
    func registerUser()
}
// MARK: - ViewModel Output
//
protocol SignupViewModelOutput {
    func configureOnButtonEnabled(onEnabled: @escaping (Bool) -> Void)
    var registrationSuccess: PassthroughSubject<Registration, Never> { get }
    var registrationError: PassthroughSubject<AlertModel, Never> { get }
}
