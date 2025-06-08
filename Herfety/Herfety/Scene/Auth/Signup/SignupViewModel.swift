//
//  SignupViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 10/05/2025.
//

import Foundation

import Foundation

class SignupViewModel {
    // MARK: - Properties
    var firstName: String = ""
    var lastName: String = ""
    var username: String = ""
    var email: String = ""
    var password: String = ""
    var confirmPassword: String = ""
    var phone: String = ""

    var onSuccess: ((Registration) -> Void)?
    var onError: ((String) -> Void)?

    private let registerService: RegisterRemoteProtocol

    // MARK: - Init
    init(registerService: RegisterRemoteProtocol = RegisterRemote(network: AlamofireNetwork())) {
        self.registerService = registerService
    }

    func registerUser() {
        
        guard !firstName.isEmpty,
              !lastName.isEmpty,
              !username.isEmpty,
              !email.isEmpty,
              !password.isEmpty,
              !confirmPassword.isEmpty,
              !phone.isEmpty else {
            onError?("All fields are required.")
            return
        }

        guard password == confirmPassword else {
            onError?("Passwords do not match.")
            return
        }

        let user = RegisterUser(
            FName: firstName,
            LName: lastName,
            UserName: username,
            Password: password,
            ConfirmPassword: confirmPassword,
            Email: email,
            Phone: phone,
            image: ""
        )

        registerService.registerUser(user: user) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let value):
                    self?.onSuccess?(value)
                case .failure(let error):
                    print("❌ Server Error Details: \(error)")
                    self?.onError?("Registration failed: \(error.localizedDescription)")
                }
            }
        }
    }
}
