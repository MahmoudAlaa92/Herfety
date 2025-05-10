//
//  LoginViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 07/05/2025.
//
import Foundation

class LoginViewModel {
    // MARK: - Properties
    private var email: String = ""
    private var password: String = ""
    private let loginService: LoginRemoteProtocol
    
    /// Outputs
    var onLoginTapped: (() -> Void)?
    private var onLoginButtonEnabled: ((Bool) -> Void)?
    var onError: ((String) -> Void)?
    /// Init
    init(loginService: LoginRemoteProtocol = LoginRemote(network: AlamofireNetwork())) {
        self.loginService = loginService
    }
}
// MARK: - LoginViewModelInput
extension LoginViewModel: LoginViewModelInput {
    func updateEmail(_ text: String) {
        email = text
        updateEnabledStateButton()
    }
    
    func updatePassword(_ text: String) {
        password = text
        updateEnabledStateButton()
    }
    
    func loginTapped() {
        loginService.login(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.handleLoginSuccess(response: response)
                case .failure(let error):
                    self?.handleLoginError(error)
                }
            }
        }
    }
    
    private func handleLoginSuccess(response: Registration) {
        onLoginTapped?()
    }
    
    private func handleLoginError(_ error: Error) {
        let errorMessage: String
        if let afError = error.asAFError, afError.isResponseValidationError {
            errorMessage = "Invalid email or password"
        } else {
            errorMessage = error.localizedDescription
        }
        onError?(errorMessage)
    }
}
// MARK: LoginViewModelOutput
//
extension LoginViewModel: LoginViewModelOutput {
    
    func configureOnButtonEnabled(onEnabled: @escaping (Bool) -> Void) {
        onLoginButtonEnabled = onEnabled
        updateEnabledStateButton()
    }
}
// MARK: Private Handlers
//
extension LoginViewModel {
    private func updateEnabledStateButton() {
        let isValid = !email.isEmpty && !password.isEmpty && password.count >= 6
        onLoginButtonEnabled?(isValid)
    }
}
