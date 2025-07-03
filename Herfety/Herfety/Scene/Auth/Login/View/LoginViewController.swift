//
//  LoginViewController.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 20/04/2024.
//
import UIKit
import AuthenticationServices
import Combine

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
    private var navBarBehavior: HerfetyNavigationController?
    var onLoginSuccess: (() -> Void)?
    private var cancellables = Set<AnyCancellable>()

    //    weak var coordinator: LoginTransitionDelegate?
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
        
        // Images UI
        logoImage.image = Images.logo
        
        // Buttons UI
        loginButton.title = "Login"
        facebookButton.title = "Continue with Facebook"
        googleButton.title = "Continue with Google"
        appleButton.title = "Continue with Apple"
        configureEmailTextField()
        configurePasswordTextField()
        configureLabelsUI()
        configureButtonUI()
        dismissKeyboardWhenTapped()
    }
    ///
    private func dismissKeyboardWhenTapped() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false // Allows other taps (e.g. buttons) to still work
        view.addGestureRecognizer(tapGesture)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    /// NavBar
    private func setUpNavigationBar() {
        navBarBehavior = HerfetyNavigationController(navigationItem: navigationItem, navigationController: navigationController)
        navBarBehavior?.configure(title: "", titleColor: Colors.primaryBlue, onPlus: {
            /// don't add plus button in loginVC
        }, showRighBtn: false)
    }
    /// Configures email text field with title and placeholder
    private func configureEmailTextField() {
        emailTextField.title = "User Name"
        emailTextField.placeholder = "Enter your user name"
        emailTextField.textfield.delegate = self
        emailTextField.textfield.returnKeyType = .next
        emailTextField.textfield.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
    }
    /// Configures password text field with title and placeholder
    private func configurePasswordTextField() {
        passwordTextField.title = "Password"
        passwordTextField.placeholder = "***********"
        passwordTextField.textfield.isSecureTextEntry = true
        passwordTextField.textfield.delegate = self
        passwordTextField.textfield.returnKeyType = .done
        passwordTextField.textfield.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    /// Configures appearance of labels
    private func configureLabelsUI() {
        titleLabel.text = "Wellcome!"
        titleLabel.textColor = Colors.primaryBlue
        titleLabel.font = .title1
        subtitleLabel.text = "please login or sign up to continue our app"
        subtitleLabel.textColor = Colors.hSocialButton
        subtitleLabel.font = .callout
        orLabel.textColor = Colors.primaryBlue
    }
    /// Configures appearance of Button
    private func configureButtonUI() {
        forgetPassword.setTitleColor(Colors.primaryBlue, for: .normal)
        forgetPassword.setTitle("Forget the password", for: .normal)
    }
}
// MARK: - Binding
//
extension LoginViewController {
    
    private func bindViewModel() {
        
        viewModel.loginSuccess
            .sink { [weak self] in
//                let vc = SuccessViewController()
//                vc.modalPresentationStyle = .fullScreen
//                self?.present(vc, animated: true)
                self?.onLoginSuccess?()
            }
            .store(in: &cancellables)
        
        viewModel.loginError
            .sink { [weak self] errorMessage in
                let alert = UIAlertController(
                    title: "Login Failed",
                    message: errorMessage,
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(alert, animated: true)
            }
            .store(in: &cancellables)
        
        viewModel.configureOnButtonEnabled { [weak self] isEnabled in
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
        viewModel.loginTapped()
    }
    
    @IBAction func forgetThePassword(_ sender: Any) {
        let vc = ForgetPasswordViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func facebookTapped(_ sender: Any) {
        viewModel.loginWithFacebook(from: self)
    }
    
    @IBAction func googleTapped(_ sender: Any) {
        viewModel.loginWithGoogle(from: self)
    }
    
    @IBAction func appleTapped(_ sender: Any) {
        let appleProvider = ASAuthorizationAppleIDProvider()
        let request = appleProvider.createRequest()
        request.requestedScopes = [.email, .fullName]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
}
extension LoginViewController : ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        view.window!
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let details = authorization.credential as? ASAuthorizationAppleIDCredential {
            viewModel.loginWithApple(credential: details)
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error.localizedDescription)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField.textfield {
            passwordTextField.textfield.becomeFirstResponder() // Move to password field
        } else if textField == passwordTextField.textfield {
            textField.resignFirstResponder() // Dismiss keyboard
        }
        return true
    }
    
}



