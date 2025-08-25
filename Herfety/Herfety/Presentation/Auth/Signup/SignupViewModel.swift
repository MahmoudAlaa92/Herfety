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
    
    // Outputs
    private let isRegisterButtonEnabled = CurrentValueSubject<Bool, Never>(false)
    let registrationSuccess = PassthroughSubject<Registration, Never>()
    let registrationError = PassthroughSubject<AlertModel, Never>()
    
    // MARK: - Init
    init(registerService: RegisterRemoteProtocol = RegisterRemote(network: AlamofireNetwork())) {
        self.registerService = registerService
        setupBindings()
    }
}
// MARK: - SignupViewModelInput
//
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
    
    func registerTapped() async {
        /// Validate passwords match
        guard self.passwordSubject.value == self.confirmPasswordSubject.value else {
            let alertItem = AlertModel(
                message: L10n.Error.passwordsMismatch,
                buttonTitle: L10n.General.ok,
                image: .warning,
                status: .error
            )
            registrationError.send(alertItem)
            return
        }
        
        do {
            let user = buildUser()
            let response = try await registerService.registerUser(user: user)
            
            await handleRegistrationSuccess(response: response)
        } catch {
            handleRegistrationError(error)
        }
    }
}
// MARK: - SignupViewModelOutput
//
extension SignupViewModel {
    func configureOnButtonEnabled(onEnabled: @escaping (Bool) -> Void) {
        isRegisterButtonEnabled
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: onEnabled)
            .store(in: &cancellables)
    }

}
// MARK: - Private Handler
//
extension SignupViewModel {
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
    }

    private func handleRegistrationSuccess(response: Registration) async {
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
        
        /// Save to UserDefaults using property wrapper
        let userDefaultsManager = UserDefaultsManager.shared
        userDefaultsManager.isLoggedIn = true
        userDefaultsManager.userId = response.id ?? 22
        userDefaultsManager.userInfo = userInfo
        
        await DataStore.shared.updateUserInfo(userInfo: userInfo)
        await DataStore.shared.updateUserId(userId: response.id ?? 22)
        await DataStore.shared.updateLoginStatus(true)

        registrationSuccess.send(response)
    }
    
    private func handleRegistrationError(_ error: Error) {
        let errorMessage: String
        if let afError = error.asAFError, afError.isResponseValidationError {
            errorMessage = L10n.Error.registrationFailed
        } else {
            errorMessage = error.localizedDescription
        }
        let alertItem = AlertModel(
            message: errorMessage,
            buttonTitle: L10n.General.ok,
            image: .warning,
            status: .error
        )
        registrationError.send(alertItem)
    }
    
    private func buildUser() -> RegisterUser {
        RegisterUser(
            FName: firstNameSubject.value,
            LName: lastNameSubject.value,
            UserName: usernameSubject.value,
            Password: passwordSubject.value,
            ConfirmPassword: confirmPasswordSubject.value,
            Email: emailSubject.value,
            Phone: phoneSubject.value,
            image: ""
        )
    }
}
