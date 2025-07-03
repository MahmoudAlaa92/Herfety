//
//  SignupViewController.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 7/04/2025.
//

import UIKit
import Combine

class SignupViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var firstNameTextField: HRTextField!
    @IBOutlet weak var lastNameTextField: HRTextField!
    @IBOutlet weak var usernameTextField: HRTextField!
    @IBOutlet weak var emailTextField: HRTextField!
    @IBOutlet weak var passwordTextField: HRTextField!
    @IBOutlet weak var confirmPasswordTextField: HRTextField!
    
    @IBOutlet weak var phoneNumber: HRTextField!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var loginButton: PrimaryButton!
    // MARK: - Properties
    private let viewModel: SignupViewModelType
    private var cancellables = Set<AnyCancellable>()
    private var navBarBehavior: HerfetyNavigationController?
    weak var coordinator: SignUpTransitionDelegate?
    // MARK: - Init
    init(viewModel: SignupViewModelType = SignupViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Life Cycle Methods
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = ""
        configureViews()
        setUpNavigationBar()
        bindViewModel()
        setupTextFields()
        dismissKeyboardWhenTapped()
    }
    // MARK: - UI Setup
    
    /// NavBar
    private func setUpNavigationBar() {
        navBarBehavior = HerfetyNavigationController(navigationItem: navigationItem, navigationController: navigationController)
        navBarBehavior?.configure(title: "", titleColor: Colors.primaryBlue, onPlus: {
            /// don't add plus button in loginVC
        }, showRighBtn: false)
    }
    private func setupTextFields() {
        firstNameTextField.textfield.addTarget(self, action: #selector(firstNameChanged), for: .editingChanged)
        lastNameTextField.textfield.addTarget(self, action: #selector(lastNameChanged), for: .editingChanged)
        usernameTextField.textfield.addTarget(self, action: #selector(usernameChanged), for: .editingChanged)
        emailTextField.textfield.addTarget(self, action: #selector(emailChanged), for: .editingChanged)
        passwordTextField.textfield.addTarget(self, action: #selector(passwordChanged), for: .editingChanged)
        confirmPasswordTextField.textfield.addTarget(self, action: #selector(confirmPasswordChanged), for: .editingChanged)
        phoneNumber.textfield.addTarget(self, action: #selector(phoneChanged), for: .editingChanged)
    }
    
    /// Configures the initial appearance of UI elements
    private func configureViews() {
        view.backgroundColor = Colors.hBackgroundColor
        
        // Images UI
        logoImage.image = Images.logo
        
        // Buttons UI
        loginButton.title = "Sign Up"
        
        configureUsernameTextField()
        configureEmailTextField()
        configurePasswordTextField()
        configurePhoneTextField()
        configureLabelsUI()
    }
    private func dismissKeyboardWhenTapped() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false // Allows other taps (e.g. buttons) to still work
        view.addGestureRecognizer(tapGesture)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    /// Configures username text field with title and placeholder
    private func configureUsernameTextField() {
        firstNameTextField.title = "First name"
        firstNameTextField.placeholder = "Enter your First name"
        
        lastNameTextField.title = "Last name"
        lastNameTextField.placeholder = "Enter your last name"
        
        usernameTextField.title = "User Name"
        usernameTextField.placeholder = "Enter your name here"
        
        firstNameTextField.textfield.delegate = self
        lastNameTextField.textfield.delegate = self
        usernameTextField.textfield.delegate = self
        emailTextField.textfield.delegate = self
        passwordTextField.textfield.delegate = self
        confirmPasswordTextField.textfield.delegate = self
        phoneNumber.textfield.delegate = self
    }
    
    /// Configures email text field with title and placeholder
    private func configureEmailTextField() {
        emailTextField.title = "Email"
        emailTextField.placeholder = "Enter your email here"
    }
    
    /// Configures password text field with title and placeholder
    private func configurePasswordTextField() {
        // Password TextField UI
        passwordTextField.title = "Password"
        passwordTextField.placeholder = "*******"
        
        // Confirm Password TextField UI
        confirmPasswordTextField.title = "Confirm Password"
        confirmPasswordTextField.placeholder = "*******"
    }
    /// Configures password text field with title and placeholder
    private func configurePhoneTextField() {
        // Phone TextField UI
        phoneNumber.title = "Phone Number"
        phoneNumber.placeholder = "+(20) 112 201 201"
    }
    
    /// Configures appearance of labels
    private func configureLabelsUI() {
        titleLabel.text = "Sign Up"
        titleLabel.textColor = Colors.primaryBlue
        
        subtitleLabel.text = "Create an new account"
        subtitleLabel.textColor = Colors.hSocialButton
    }
}
// MARK: - Actions
//
extension SignupViewController {
    @IBAction func loginTapped(_ sender: Any) {
        viewModel.registerUser()
    }
    
    @objc private func firstNameChanged() {
        viewModel.updateFirstName(firstNameTextField.textfield.text ?? "")
    }
    
    @objc private func lastNameChanged() {
        viewModel.updateLastName(lastNameTextField.textfield.text ?? "")
    }
    
    @objc private func usernameChanged() {
        viewModel.updateUsername(usernameTextField.textfield.text ?? "")
    }
    
    @objc private func emailChanged() {
        viewModel.updateEmail(emailTextField.textfield.text ?? "")
    }
    
    @objc private func passwordChanged() {
        viewModel.updatePassword(passwordTextField.textfield.text ?? "")
    }
    
    @objc private func confirmPasswordChanged() {
        viewModel.updateConfirmPassword(confirmPasswordTextField.textfield.text ?? "")
    }
    
    @objc private func phoneChanged() {
        viewModel.updatePhone(phoneNumber.textfield.text ?? "")
    }
}
// MARK: - Binding
//
extension SignupViewController {
    private func bindViewModel() {
        viewModel.configureOnButtonEnabled { [weak self] isEnabled in
            self?.loginButton.isEnabled = isEnabled
            self?.loginButton.alpha = isEnabled ? 1.0 : 0.7
        }
        
        viewModel.registrationSuccess
            .sink { [weak self] _ in
                let successVC = SuccessViewController()
                successVC.modalPresentationStyle = .fullScreen
                self?.present(successVC, animated: true)
            }
            .store(in: &cancellables)
        
        viewModel.registrationError
            .sink { [weak self] errorMessage in
                let alertItem = AlertModel(
                    message: errorMessage,
                    buttonTitle: "Ok",
                    image: .warning,
                    status: .error
                )
                self?.presentCustomAlert(with: alertItem)
            }
            .store(in: &cancellables)
    }
}
// MARK: - Alert Presentation
//
extension SignupViewController {
    func presentCustomAlert(with alertItem: AlertModel) {
        let alertVC = AlertViewController(
            nibName: "AlertViewController",
            bundle: nil
        )
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        alertVC.loadViewIfNeeded()
        /// Ensure outlets are connected
        
        alertVC.show(alertItem: alertItem)
        
        /// Optional: dismiss on button press
        alertVC.actionHandler = { [weak alertVC] in
            alertVC?.dismiss(animated: true)
        }
        self.present(alertVC, animated: true)
    }
}
// MARK: - Textfield
//
extension SignupViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextField: UITextField?
        
        switch textField {
        case firstNameTextField.textfield:
            nextField = lastNameTextField.textfield
        case lastNameTextField.textfield:
            nextField = usernameTextField.textfield
        case usernameTextField.textfield:
            nextField = emailTextField.textfield
        case emailTextField.textfield:
            nextField = passwordTextField.textfield
        case passwordTextField.textfield:
            nextField = confirmPasswordTextField.textfield
        case confirmPasswordTextField.textfield:
            nextField = phoneNumber.textfield
        case phoneNumber.textfield:
            nextField = nil
        default:
            nextField = nil
        }
        
        if let next = nextField {
            scrollView.scrollRectToVisible(next.frame, animated: true)
            next.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return true
    }
    
}
