//
//  LoginViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 07/05/2025.
//
import Foundation

class LoginViewModel {
    private var email: String = ""
    private var password: String = ""
    var onLoginButtonEnabled: ((Bool)-> Void)?
    var onLoginTapped: (() -> Void)?
}
// MARK: LoginViewModelInput
//
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
        onLoginTapped?()
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
    func updateEnabledStateButton() {
        let isEmailValid = !email.isEmpty
        let isPasswordValid = !password.isEmpty
        let isButtonEnabled = isEmailValid && isPasswordValid

        onLoginButtonEnabled?(isButtonEnabled)
    }
}
