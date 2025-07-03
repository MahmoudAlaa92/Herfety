//
//  SignupViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 10/05/2025.
//
import Combine
import Foundation

class SignupViewModel: SignupViewModelType {
    // MARK: - Properties
    private let registerService: RegisterRemoteProtocol
    private var cancellables = Set<AnyCancellable>()
    
    // Input handling
    private let firstNameSubject = CurrentValueSubject<String, Never>("")
    private let lastNameSubject = CurrentValueSubject<String, Never>("")
    private let usernameSubject = CurrentValueSubject<String, Never>("")
    private let emailSubject = CurrentValueSubject<String, Never>("")
    private let passwordSubject = CurrentValueSubject<String, Never>("")
    private let confirmPasswordSubject = CurrentValueSubject<String, Never>("")
    private let phoneSubject = CurrentValueSubject<String, Never>("")
    private let registerTappedSubject = PassthroughSubject<Void, Never>()
    
    // Outputs
    private let isRegisterButtonEnabled = CurrentValueSubject<Bool, Never>(false)
    let registrationSuccess = PassthroughSubject<Registration, Never>()
    let registrationError = PassthroughSubject<String, Never>()
    
    // MARK: - Init
    init(registerService: RegisterRemoteProtocol = RegisterRemote(network: AlamofireNetwork())) {
        self.registerService = registerService
        setupBindings()
    }
    
    private func setupBindings() {
        let formValidation = Publishers.CombineLatest(
            Publishers.CombineLatest4(
                firstNameSubject,
                lastNameSubject,
                usernameSubject,
                emailSubject
            ),
            Publishers.CombineLatest3(
                passwordSubject,
                confirmPasswordSubject,
                phoneSubject
            )
        ).map { namesAndEmail, passwordsAndPhone in
                let (firstName, lastName, username, email) = namesAndEmail
                let (password, confirmPassword, phone) = passwordsAndPhone
                
                return !firstName.isEmpty &&
                !lastName.isEmpty &&
                !username.isEmpty &&
                !email.isEmpty    &&
                !password.isEmpty &&
                !confirmPassword.isEmpty &&
                !phone.isEmpty
            }
            formValidation
            .subscribe(isRegisterButtonEnabled)
            .store(in: &cancellables)
        
        // Handle registration requests
        registerTappedSubject
            .map { [weak self] _ -> (RegisterUser, String)? in
                guard let self = self else { return nil }
                
                /// Validate passwords match
                guard self.passwordSubject.value == self.confirmPasswordSubject.value else {
                    return nil
                }
                
                return (RegisterUser(
                    FName: self.firstNameSubject.value,
                    LName: self.lastNameSubject.value,
                    UserName: self.usernameSubject.value,
                    Password: self.passwordSubject.value,
                    ConfirmPassword: self.confirmPasswordSubject.value,
                    Email: self.emailSubject.value,
                    Phone: self.phoneSubject.value,
                    image: ""
                ), self.passwordSubject.value)
            }
            .compactMap { $0 } /// Remove nil (including when passwords don't match)
            .flatMap { [weak self] user, password -> AnyPublisher<Result<Registration, Error>, Never> in
                guard let self = self else { return Empty().eraseToAnyPublisher() }
                
                return Future<Result<Registration, Error>, Never> { promise in
                    self.registerService.registerUser(user: user) { result in
                        promise(.success(result))
                    }
                }
                .eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                switch result {
                case .success(let response):
                    self?.handleRegistrationSuccess(response: response)
                case .failure(let error):
                    self?.handleRegistrationError(error)
                }
            }
            .store(in: &cancellables)
    }
    
    private func handleRegistrationSuccess(response: Registration) {
        let userInfo = RegisterUser(
            FName: firstNameSubject.value,
            LName: lastNameSubject.value,
            UserName: usernameSubject.value,
            Password: passwordSubject.value,
            ConfirmPassword: confirmPasswordSubject.value,
            Email: emailSubject.value,
            Phone: phoneSubject.value,
            image: ""
        )
        
        CustomeTabBarViewModel.shared.userInfo = userInfo
        CustomeTabBarViewModel.shared.userId = response.id ?? 1
        registrationSuccess.send(response)
    }
    
    private func handleRegistrationError(_ error: Error) {
        let errorMessage: String
        if let afError = error.asAFError, afError.isResponseValidationError {
            errorMessage = "Registration failed: Please check your input"
        } else {
            errorMessage = error.localizedDescription
        }
        registrationError.send(errorMessage)
    }
}
// MARK: - SignupViewModelInput
extension SignupViewModel {
    func updateFirstName(_ text: String) {
        firstNameSubject.send(text)
    }
    
    func updateLastName(_ text: String) {
        lastNameSubject.send(text)
    }
    
    func updateUsername(_ text: String) {
        usernameSubject.send(text)
    }
    
    func updateEmail(_ text: String) {
        emailSubject.send(text)
    }
    
    func updatePassword(_ text: String) {
        passwordSubject.send(text)
    }
    
    func updateConfirmPassword(_ text: String) {
        confirmPasswordSubject.send(text)
    }
    
    func updatePhone(_ text: String) {
        phoneSubject.send(text)
    }
    
    func registerUser() {
        // Validate passwords match before proceeding
        guard passwordSubject.value == confirmPasswordSubject.value else {
            registrationError.send("Passwords do not match")
            return
        }
        registerTappedSubject.send()
    }
}

// MARK: - SignupViewModelOutput
extension SignupViewModel {
    func configureOnButtonEnabled(onEnabled: @escaping (Bool) -> Void) {
        isRegisterButtonEnabled
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: onEnabled)
            .store(in: &cancellables)
    }
}
