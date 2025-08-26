//
//  LoginViewController.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 20/04/2024.
//

import AuthenticationServices
import Combine
import UIKit

class LoginViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var emailTextField: HRTextField!
    @IBOutlet weak var passwordTextField: HRTextField!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var forgetPassword: UIButton!
    @IBOutlet weak var loginButton: PrimaryButton!
    @IBOutlet weak var facebookButton: FacebookButton!
    @IBOutlet weak var appleButton: AppleButton!
    @IBOutlet weak var googleButton: GoogleButton!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var orLabel: UILabel!
    // MARK: - Properties
    var viewModel: LoginViewModelType
    private lazy var navBarBehavior = HerfetyNavigationController(
        navigationItem: navigationItem,
        navigationController: navigationController)
    private var cancellables = Set<AnyCancellable>()
    weak var coordinator: LoginTransitionDelegate?

    // MARK: - Init
    init(viewModel: LoginViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        setUpNavigationBar()
        bindViewModel()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        /// Keep nav bar visible
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
// MARK: - Configuration
//
extension LoginViewController {
    /// Configures the initial appearance of UI elements
    private func configureViews() {
        view.backgroundColor = Colors.hPrimaryBackground
        lineView.backgroundColor = Colors.hTextFieldUnderLine

        /// Images UI
        logoImage.image = Images.logo

        /// Buttons UI
        loginButton.title = L10n.Auth.login
        facebookButton.title = L10n.Auth.Login.facebook
        googleButton.title = L10n.Auth.Login.google
        appleButton.title = L10n.Auth.Login.apple
        configureEmailTextField()
        configurePasswordTextField()
        configureLabelsUI()
        configureButtonUI()
        dismissKeyboardWhenTapped()
    }
    ///
    private func dismissKeyboardWhenTapped() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    /// NavBar
    private func setUpNavigationBar() {
        navBarBehavior.configure(
            title: "",
            titleColor: Colors.primaryBlue,
            onPlus: {
                /// don't add plus button in loginVC
            },
            showRighBtn: false,
            showBackButton: true) { [weak self] in
                self?.coordinator?.backToSplash()
            }
    }
    /// Configures email text field with title and placeholder
    private func configureEmailTextField() {
        emailTextField.title = L10n.Auth.Login.Username.title
        emailTextField.placeholder = L10n.Auth.Login.Username.placeholder
        emailTextField.textfield.delegate = self
        emailTextField.textfield.returnKeyType = .next
        emailTextField.textfield.addTarget(
            self,
            action: #selector(textDidChange),
            for: .editingChanged
        )

    }
    /// Configures password text field with title and placeholder
    private func configurePasswordTextField() {
        passwordTextField.title = L10n.Auth.Login.Password.title
        passwordTextField.placeholder = L10n.Auth.Login.Password.placeholder
        passwordTextField.textfield.isSecureTextEntry = true
        passwordTextField.textfield.delegate = self
        passwordTextField.textfield.returnKeyType = .done
        passwordTextField.textfield.addTarget(
            self,
            action: #selector(textDidChange),
            for: .editingChanged
        )
    }
    /// Configures appearance of labels
    private func configureLabelsUI() {
        titleLabel.text = L10n.Auth.welcome
        titleLabel.textColor = Colors.primaryBlue
        titleLabel.font = .title1
        subtitleLabel.text = L10n.Auth.Login.subtitle
        subtitleLabel.textColor = Colors.hSocialButton
        subtitleLabel.font = .callout
        orLabel.textColor = Colors.primaryBlue
    }
    /// Configures appearance of Button
    private func configureButtonUI() {
        forgetPassword.setTitleColor(Colors.primaryBlue, for: .normal)
        forgetPassword.setTitle(L10n.Auth.ForgotPassword.title, for: .normal)
    }
}
// MARK: - Binding
//
extension LoginViewController {

    private func bindViewModel() {

        viewModel
            .loginSuccess
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.loginButton.hideLoader()
                self?.coordinator?.goToSuccessVC()
            }
            .store(in: &cancellables)

        viewModel
            .loginError
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                self?.loginButton.hideLoader()
                let alert = UIAlertController(
                    title: L10n.Auth.Login.failed,
                    message: errorMessage,
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: L10n.General.ok, style: .default))
                self?.present(alert, animated: true)
            }
            .store(in: &cancellables)
        
           viewModel
               .isLoading
               .receive(on: DispatchQueue.main)
               .sink { [weak self] isLoading in
                   if isLoading {
                       self?.loginButton.showLoader(userInteraction: true)
                   } else {
                       self?.loginButton.hideLoader()
                   }
               }
               .store(in: &cancellables)
        viewModel
            .configureOnButtonEnabled { [weak self] isEnabled in
            self?.loginButton.isEnabled = isEnabled
            self?.loginButton.alpha = isEnabled ? 1.0 : 0.7
        }
    }
}
// MARK: - Private Handlers
//
extension LoginViewController {
    @objc func textDidChange(_ sender: UITextField) {
        guard let text = sender.text else { return }

        if sender == emailTextField.textfield {
            viewModel.updateEmail(text)
        } else if sender == passwordTextField.textfield {
            viewModel.updatePassword(text)
        }
    }
}
// MARK: - Actions
//
extension LoginViewController {
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        Task {
            
            await viewModel.loginTapped()
        }
    }

    @IBAction func forgetThePassword(_ sender: Any) {
        self.coordinator?.goToForgetPasswordVC()
    }
    @IBAction func facebookTapped(_ sender: Any) {
        Task {
            await viewModel.loginWithFacebook(from: self)
        }
    }

    @IBAction func googleTapped(_ sender: Any) {
        Task { 
            await viewModel.loginWithGoogle(from: self)
        }
    }

    @IBAction func appleTapped(_ sender: Any) {
        let appleProvider = ASAuthorizationAppleIDProvider()
        let request = appleProvider.createRequest()
        request.requestedScopes = [.email, .fullName]
        let controller = ASAuthorizationController(authorizationRequests: [
            request
        ])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
}
// MARK: - TextFieldDelegate
//
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField.textfield {
            passwordTextField.textfield.becomeFirstResponder()  // Move to password field
        } else if textField == passwordTextField.textfield {
            textField.resignFirstResponder()  // Dismiss keyboard
        }
        return true
    }

}
// MARK: - AppleDelegate
//
extension LoginViewController: ASAuthorizationControllerDelegate,
    ASAuthorizationControllerPresentationContextProviding
{

    func presentationAnchor(for controller: ASAuthorizationController)
        -> ASPresentationAnchor
    {
        view.window!
    }
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        if let details = authorization.credential
            as? ASAuthorizationAppleIDCredential
        {
            Task {
                await viewModel.loginWithApple(credential: details)
            }
        }
    }

    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithError error: Error
    ) {
        print(error.localizedDescription)
    }
}
