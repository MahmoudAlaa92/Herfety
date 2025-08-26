//
//  ForgetPasswordViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 14/05/2025.
//

import Foundation
import Combine

class ForgetPasswordViewModel: ForgetPasswordViewModelType {
    // MARK: - Properties
    private let resetService: ResetPasswordRemoteProtocol
    private var cancellables = Set<AnyCancellable>()
    
    // Inputs as Combine subjects
    let userNameSubject = CurrentValueSubject<String, Never>("")
    let currentPasswordSubject = CurrentValueSubject<String, Never>("")
    let newPasswordSubject = CurrentValueSubject<String, Never>("")
    let confirmPasswordSubject = CurrentValueSubject<String, Never>("")
    
    // Output streams
    private let isButtonEnabled = CurrentValueSubject<Bool, Never>(false)
    let onSuccess = PassthroughSubject<Void, Never>()
    let onError = PassthroughSubject<AlertModel, Never>()
    let isLoading = PassthroughSubject<Bool, Never>()
    
    // MARK: - Init
    init(
        resetService: ResetPasswordRemoteProtocol = ResetPasswordRemote(
            network: AlamofireNetwork()
        )
    ) {
        self.resetService = resetService
        setupBindings()
    }
    private func setupBindings() {
        Publishers.CombineLatest4(
            userNameSubject,
            currentPasswordSubject,
            newPasswordSubject,
            confirmPasswordSubject
        )
        .map {
            !$0.0.isEmpty &&
            !$0.1.isEmpty &&
            !$0.2.isEmpty &&
            !$0.3.isEmpty
        }
        .subscribe(isButtonEnabled)
        .store(in: &cancellables)
    }
    
    private func handleResetSuccess(response: ResponseReset) {
        onSuccess.send()
    }
    
    private func handleResetError(_ error: Error) {
        let errorMessage: String
        if let afError = error.asAFError, afError.isResponseValidationError {
            errorMessage = L10n.Auth.ForgotPassword.Error.invalidInput
        } else {
            errorMessage = error.localizedDescription
        }
        let alert = AlertModel(
            message: errorMessage,
            buttonTitle: L10n.General.ok,
            image: .warning,
            status: .warning
        )
        onError.send(alert)
    }
}
// MARK: - ForgetPasswordViewModelInput
//
extension ForgetPasswordViewModel {
    func updateUserName(_ text: String) {
        userNameSubject.send(text)
    }
    
    func updateCurrentPassword(_ text: String) {
        currentPasswordSubject.send(text)
    }
    
    func updateNewPassword(_ text: String) {
        newPasswordSubject.send(text)
    }
    
    func updateConfirmPassword(_ text: String) {
        confirmPasswordSubject.send(text)
    }
    
    func resetTapped() async {
        guard !userNameSubject.value.isEmpty,
              !currentPasswordSubject.value.isEmpty,
              !newPasswordSubject.value.isEmpty,
              !confirmPasswordSubject.value.isEmpty
        else {
            let alert = AlertModel(
                message: L10n.Auth.ForgotPassword.Error.emptyFields,
                buttonTitle: L10n.General.ok,
                image: .warning,
                status: .warning
            )
            onError.send(alert)
            return
        }
        
        isLoading.send(true)
        
        defer { isLoading.send(false) }
        
        do {
            let response = try await resetService.reset(
                parameter: ResetPassword(
                    UserName: userNameSubject.value,
                    CurrentPassword: currentPasswordSubject.value,
                    NewPassword: newPasswordSubject.value,
                    ConfirmPassword: confirmPasswordSubject.value
                )
            )
            handleResetSuccess(response: response)
        } catch {
            handleResetError(error)
        }
        
        isLoading.send(false)
    }
}

// MARK: - ForgetPasswordViewModelOutput
//
extension ForgetPasswordViewModel {
    func configureOnButtonEnabled(onEnabled: @escaping (Bool) -> Void) {
        isButtonEnabled
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: onEnabled)
            .store(in: &cancellables)
    }
}
