//
//  ForgetPasswordViewModelType.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 14/05/2025.
//

import Combine

/// Combines both input & output responsibilities
typealias ForgetPasswordViewModelType = ForgetPasswordViewModelInput & ForgetPasswordViewModelOutput

// MARK: - ViewModel Input
//
protocol ForgetPasswordViewModelInput {
    func updateUserName(_ text: String)
    func updateCurrentPassword(_ text: String)
    func updateNewPassword(_ text: String)
    func updateConfirmPassword(_ text: String)
    func resetTapped() async
}

// MARK: - ViewModel Output
//
protocol ForgetPasswordViewModelOutput {
    func configureOnButtonEnabled(onEnabled: @escaping (Bool) -> Void)
    var onSuccess: PassthroughSubject<Void, Never> { get }
    var onError: PassthroughSubject<AlertModel, Never> { get }
    var isLoading: PassthroughSubject<Bool, Never> { get }
}
