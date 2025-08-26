//
//  LoginViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 07/05/2025.
//

import AuthenticationServices
import Combine
import FacebookLogin
import Firebase
import FirebaseAuth
import Foundation
import GoogleSignIn

class LoginViewModel: LoginViewModelType {

    // MARK: - Properties
    private let loginService: LoginRemoteProtocol
    private var cancellables = Set<AnyCancellable>()

    /// Input handling
    private let emailSubject = CurrentValueSubject<String, Never>("")
    private let passwordSubject = CurrentValueSubject<String, Never>("")

    /// Outputs
    private let isLoginButtonEnabled = CurrentValueSubject<Bool, Never>(false)
    let loginSuccess = PassthroughSubject<Void, Never>()
    let loginError = PassthroughSubject<String, Never>()
    let isLoading = PassthroughSubject<Bool, Never>()

    //MARK: - Init
    init(
        loginService: LoginRemoteProtocol = LoginRemote(
            network: AlamofireNetwork()
        )
    ) {
        self.loginService = loginService
        setupBindings()
    }

    private func setupBindings() {
        /// Combine email and password for button state
        Publishers
            .CombineLatest(emailSubject, passwordSubject)
            .map { !$0.isEmpty && !$1.isEmpty }
            .subscribe(isLoginButtonEnabled)
            .store(in: &cancellables)
    }

    private func handelLoginSuccess(response: Registration) async {
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
        
        /// Save to UserDefaults using property wrapper
        let userDefaultsManager = UserDefaultsManager.shared
        userDefaultsManager.isLoggedIn = true
        userDefaultsManager.userId = response.id ?? 22
        userDefaultsManager.userInfo = userInfo
        
        await DataStore.shared.updateUserId(userId: response.id ?? 22)
        await DataStore.shared.updateUserInfo(userInfo: userInfo)
        await DataStore.shared.updateLoginStatus(true)

        loginSuccess.send()
    }

    private func handleLoginError(_ error: Error) {
        let errorMessage: String
        if let afError = error.asAFError, afError.isResponseValidationError {
            errorMessage = L10n.Error.invalidCredentials
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

    func loginTapped() async {
        guard !emailSubject.value.isEmpty && !passwordSubject.value.isEmpty
        else {
            loginError.send(L10n.Error.missingEmailPassword)
            return
        }

        isLoading.send(true)

        do {
            let response = try await loginService.login(
                email: emailSubject.value,
                password: passwordSubject.value
            )
            await handelLoginSuccess(response: response)
            loginSuccess.send()

        } catch {
            handleLoginError(error)
        }
    }
    @MainActor
    func loginWithFacebook(from viewController: UIViewController) async {
        isLoading.send(true)

        let loginManager = LoginManager()

        let loginResult: Result<String, Error> = await withCheckedContinuation {
            continuation in
            loginManager.logIn(
                permissions: ["public_profile", "email"],
                from: viewController
            ) { result, error in
                if let error = error {
                    continuation.resume(returning: .failure(error))
                    return
                }

                guard let tokenString = AccessToken.current?.tokenString else {
                    continuation.resume(
                        returning: .failure(
                            NSError(
                                domain: "FB",
                                code: 401,
                                userInfo: [
                                    NSLocalizedDescriptionKey: L10n.Error.noAccessToken
                                ]
                            )
                        )
                    )
                    return
                }
                continuation.resume(returning: .success(tokenString))
            }
        }

        switch loginResult {
        case .failure(let error):
            loginError.send(error.localizedDescription)
        case .success(let token):
            do {
                let credential = FacebookAuthProvider.credential(
                    withAccessToken: token
                )
                let authResult = try await Auth.auth().signIn(with: credential)
                await handleFirebaseLogin(with: authResult.user)
            } catch {
                loginError.send(error.localizedDescription)
            }
        }
        isLoading.send(false)
    }

    @MainActor
    func loginWithGoogle(from viewController: UIViewController) async {
        isLoading.send(true)
        
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            self.loginError.send(L10n.Error.clientIdNotFound)
            isLoading.send(false)
            return
        }

        let configuration = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = configuration

        do {
            let result = try await GIDSignIn.sharedInstance.signIn(
                withPresenting: viewController
            )

            guard let idToken = result.user.idToken?.tokenString else {
                loginError.send(L10n.Error.googleTokenFailed)
                isLoading.send(false)
                return
            }

            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken,
                accessToken: result.user.accessToken.tokenString
            )

            let authResult = try await Auth.auth().signIn(with: credential)
            await handleFirebaseLogin(with: authResult.user)
        } catch {
            loginError.send(error.localizedDescription)
        }
        isLoading.send(false)
    }
    @MainActor
    func loginWithApple(credential: ASAuthorizationAppleIDCredential) async {}
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
// MARK: - Private Handlers
//
extension LoginViewModel {
    private func createUserInfo(
        displayName: String,
        email: String,
        phone: String?,
        imageUrl: String?
    ) -> RegisterUser {
        let nameComponents = displayName.split(separator: " ")
        let firstName = nameComponents.first.map(String.init) ?? ""
        let lastName = nameComponents.dropFirst().joined(separator: " ")

        return RegisterUser(
            FName: firstName,
            LName: lastName,
            UserName: firstName + " " + lastName,
            Password: "",
            ConfirmPassword: "",
            Email: email,
            Phone: phone ?? "01142128919",
            image: imageUrl ?? ""
        )
    }

    private func handleFirebaseLogin(with user: FirebaseAuth.User) async {
        let userInfo = createUserInfo(
            displayName: user.displayName ?? "",
            email: user.email ?? "",
            phone: user.phoneNumber,
            imageUrl: user.photoURL?.absoluteString
        )
        
        /// Save to UserDefaults using property wrapper
        let userDefaultsManager = UserDefaultsManager.shared
        userDefaultsManager.isLoggedIn = true
        userDefaultsManager.userInfo = userInfo
        
        await DataStore.shared.updateUserInfo(userInfo: userInfo)
        await DataStore.shared.updateLoginStatus(true)
        await DataStore.shared.loadUserProfileImage()
        
        loginSuccess.send()
    }
}
