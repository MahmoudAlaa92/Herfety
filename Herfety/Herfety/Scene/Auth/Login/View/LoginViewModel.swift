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
    
    // MARK: - Facebook Login
    func loginWithFacebook(from viewController: UIViewController) {
        let fbLoginManager = LoginManager()
        fbLoginManager.logIn(permissions: ["public_profile", "email"], from: viewController) { [weak self] result, error in
            if let error = error {
                self?.onError?(error.localizedDescription)
                return
            }
            
            guard let token = AccessToken.current?.tokenString else {
                self?.onError?("Failed to retrieve Facebook access token.")
                return
            }
            
            let credential = FacebookAuthProvider.credential(withAccessToken: token)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    self?.onError?(error.localizedDescription)
                    return
                }
                self?.onLoginTapped?()
            }
        }
    }
    // MARK: - Google Login
    func loginWithGoogle(from viewController: UIViewController) {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            onError?("Client ID not found")
            return
        }
        
        let configuration = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = configuration
        
        GIDSignIn.sharedInstance.signIn(withPresenting: viewController) { [weak self] result, error in
            if let error = error {
                self?.onError?(error.localizedDescription)
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString else {
                self?.onError?("Failed to retrieve Google ID token.")
                return
            }
            
            let accessToken = user.accessToken.tokenString
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    self?.onError?(error.localizedDescription)
                    return
                }
                guard let firebaseUser = authResult?.user else {
                    self?.onError?("Failed to get user info.")
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
                print(user)

                self?.onLoginTapped?()
            }
        }
    }

    // MARK: - Apple Login
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
        
        // Simulate success or error
        if !userId.isEmpty {
            onLoginTapped?()
        } else {
            onError?("Apple login failed.")
        }
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
        let isValid = !email.isEmpty && !password.isEmpty
        onLoginButtonEnabled?(isValid)
    }
}
