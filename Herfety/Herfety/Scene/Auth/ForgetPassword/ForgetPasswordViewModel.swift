//
//  ForgetPasswordViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 14/05/2025.
//

import Foundation

class ForgetPasswordViewModel {
    // MARK: - Properties
    private var userName: String = ""
    private var currentPassword: String = ""
    private var newPassword: String = ""
    private var confirmPassword: String = ""
    private let resetService: ResetPasswordRemoteProtocol
    /// Outputs
    var onResetTapped: (() -> Void)?
    var onError: ((String) -> Void)?
    private var onResetButtonEnabled: ((Bool) -> Void)?

    /// Init
    init(resetService: ResetPasswordRemoteProtocol = ResetPasswordRemote(network: AlamofireNetwork())){
        self.resetService = resetService
    }
}
// MARK: - ResetViewModelInput
extension ForgetPasswordViewModel {
    func upadateUserName(_ text: String) {
        userName = text
        updateEnabledStateButton()
    }
    func upadteCurrentPassword(_ text: String) {
        currentPassword = text
        updateEnabledStateButton()
    }
    func upadteNewPassword(_ text: String) {
        newPassword = text
        updateEnabledStateButton()
    }
    func upadteConfirmPassword(_ text: String) {
        confirmPassword = text
        updateEnabledStateButton()
    }
    func resetTapped() {
        resetService.reset(parameter: ResetPassword(
            UserName: userName,
            CurrentPassword: currentPassword,
            NewPassword: newPassword,
            ConfirmPassword: confirmPassword)) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let response):
                        print(response.message)
                        self?.handleResetSuccess(response: response)
                    case .failure(let error):
                        self?.handleLoginError(error)
                    }
                }
            }
    }
    private func handleResetSuccess(response: ResponseReset) {
        onResetTapped?()
    }
    private func handleLoginError(_ error: Error) {
        let errorMessage: String
        if let afError = error.asAFError, afError.isResponseValidationError {
            errorMessage = "There exist Inavalid Input"
        } else {
            errorMessage = error.localizedDescription
        }
        onError?(errorMessage)
    }
}
// MARK: - ResetViewModelOutput
extension ForgetPasswordViewModel {
    func configureOnButtonEnabled(onEnabled: @escaping (Bool) -> Void) {
        onResetButtonEnabled = onEnabled
        updateEnabledStateButton()
    }
}
// MARK: - Private Handlers
extension ForgetPasswordViewModel {
    func updateEnabledStateButton() {
        let isValid = !userName.isEmpty &&
                      !currentPassword.isEmpty &&
                      !newPassword.isEmpty &&
                      !confirmPassword.isEmpty 
        onResetButtonEnabled?(isValid)
    }
}
