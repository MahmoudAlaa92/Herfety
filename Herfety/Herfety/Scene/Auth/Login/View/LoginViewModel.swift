//
//  LoginViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 07/05/2025.
//
import Foundation
import Firebase
import FirebaseAuth
import FacebookLogin
import GoogleSignIn
import AuthenticationServices
import Combine

class LoginViewModel: LoginViewModelType {
    // MARK: - Properties
    private let loginService: LoginRemoteProtocol
    private var cancellables = Set<AnyCancellable>()
    
    /// Input handling
    private let emailSubject = CurrentValueSubject<String, Never>("")
    private let passwordSubject = CurrentValueSubject<String, Never>("")
    private let loginTappedSubject = PassthroughSubject<Void, Never>()
    
    /// Outputs
    private let isLoginButtonEnabled = CurrentValueSubject<Bool, Never>(false)
    let loginSuccess = PassthroughSubject<Void, Never>()
    let loginError = PassthroughSubject<String, Never>()
    
    /// Init
    init(loginService: LoginRemoteProtocol = LoginRemote(network: AlamofireNetwork())) {
        self.loginService = loginService
        setupBindings()
    }
    
    private func setupBindings() {
        /// Combine email and password for button state
        Publishers.CombineLatest(emailSubject, passwordSubject)
            .map { !$0.isEmpty && !$1.isEmpty }
            .subscribe(isLoginButtonEnabled)
            .store(in: &cancellables)
        
        /// Handle login requests
        loginTappedSubject
            .map { [weak self] _ -> (String, String)? in
                guard let self = self else { return nil }
                return (self.emailSubject.value, self.passwordSubject.value)
            }
            .compactMap { $0 } /// remove nil
            .flatMap { [weak self] email, password -> AnyPublisher<Result<Registration, Error>, Never> in
                guard let self = self else { return Empty().eraseToAnyPublisher() }
                
                return Future<Result<Registration, Error>, Never> { promise in
                    self.loginService.login(email: email, password: password) { result in
                        promise(.success(result))
                    }
                }
                .eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                switch result {
                case .success(let response):
                    self?.handleLoginSuccess(response: response)
                case .failure(let error):
                    self?.handleLoginError(error)
                }
            }
            .store(in: &cancellables)
    }
    private func handleLoginSuccess(response: Registration) {
        UserSessionManager.isLoggedIn = true
        let userInfo = RegisterUser(
            FName: "",
            LName: "",
            UserName: response.userName ?? "",
            Password: passwordSubject.value,
            ConfirmPassword: passwordSubject.value,
            Email: response.email ?? "",
            Phone: "",
            image: ""
        )
        CustomeTabBarViewModel.shared.userInfo = userInfo
        CustomeTabBarViewModel.shared.userId = response.id ?? 1
        loginSuccess.send()
    }
    private func handleLoginError(_ error: Error) {
        let errorMessage: String
        if let afError = error.asAFError, afError.isResponseValidationError {
            errorMessage = "Invalid email or password"
        } else {
            errorMessage = error.localizedDescription
        }
        loginError.send(errorMessage)
    }
}
// MARK: - LoginViewModelInput
//
extension LoginViewModel {
    func updateEmail(_ text: String) {
        emailSubject.send(text)
    }
    
    func updatePassword(_ text: String) {
        passwordSubject.send(text)
    }
    
    func loginTapped() {
        loginTappedSubject.send()
    }
    
    func loginWithFacebook(from viewController: UIViewController) {
        let fbLoginManager = LoginManager()
        fbLoginManager.logIn(permissions: ["public_profile", "email"], from: viewController) { [weak self] result, error in
            if let error = error {
                self?.loginError.send(error.localizedDescription)
                return
            }
            
            guard let token = AccessToken.current?.tokenString else {
                self?.loginError.send("Failed to retrieve Facebook access token.")
                return
            }
            
            let credential = FacebookAuthProvider.credential(withAccessToken: token)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    self?.loginError.send(error.localizedDescription)
                    return
                }
                // Handle successful Facebook login
            }
        }
    }
    
    func loginWithGoogle(from viewController: UIViewController) {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            self.loginError.send("Client ID not found")
            return
        }
        
        let configuration = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = configuration
        
        GIDSignIn.sharedInstance.signIn(withPresenting: viewController) { [weak self] result, error in
            if let error = error {
                self?.loginError.send(error.localizedDescription)
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString else {
                self?.loginError.send("Failed to retrieve Google ID token.")
                return
            }
            
            let accessToken = user.accessToken.tokenString
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    self?.loginError.send(error.localizedDescription)
                    return
                }
                guard let firebaseUser = authResult?.user else {
                    self?.loginError.send("Failed to get user info.")
                    return
                }
                
                let displayName = firebaseUser.displayName ?? ""
                let nameComponents = displayName.split(separator: " ")
                let firstName = nameComponents.first.map(String.init) ?? ""
                let lastName = nameComponents.dropFirst().joined(separator: " ")
                
                let email = firebaseUser.email ?? ""
                let phone = firebaseUser.phoneNumber ?? "01142128919"
                let imageUrl = firebaseUser.photoURL?.absoluteString ?? ""
                
                let userInfo = RegisterUser(
                    FName: firstName,
                    LName: lastName,
                    UserName: firstName + " " + lastName,
                    Password: "",
                    ConfirmPassword: "",
                    Email: email,
                    Phone: phone,
                    image: imageUrl
                )
                CustomeTabBarViewModel.shared.userInfo = userInfo
            }
        }
    }
    func loginWithApple(credential: ASAuthorizationAppleIDCredential) {
        let userId = credential.user
        let email = credential.email ?? ""
        
        let fullName: String
        if let nameComponents = credential.fullName {
            let formatter = PersonNameComponentsFormatter()
            fullName = formatter.string(from: nameComponents)
        } else {
            fullName = ""
        }
        
        // Example usage (Firebase, custom backend, etc.)
        print("Apple Sign-In Info:")
        print("User ID: \(userId)")
        print("Email: \(email)")
        print("Full Name: \(fullName)")
        
        if userId.isEmpty {
            loginError.send("Apple login failed.")
        }
    }
}
// MARK: - LoginViewModelOutput
//
extension LoginViewModel {
    func configureOnButtonEnabled(onEnabled: @escaping (Bool) -> Void) {
        isLoginButtonEnabled
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: onEnabled)
            .store(in: &cancellables)
    }
}
