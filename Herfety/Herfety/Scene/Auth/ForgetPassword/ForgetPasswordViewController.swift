//
//  SignupViewController.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 7/04/2025.
//

import UIKit
import Combine

class ForgetPasswordViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var usernameTextField: HRTextField!
    @IBOutlet weak var currentPasswordTextField: HRTextField!
    @IBOutlet weak var newPasswordTextField: HRTextField!
    @IBOutlet weak var confirmPasswordTextField: HRTextField!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var resetBtn: HerfetyButton!
    // MARK: - Properties
    private let viewModel: ForgetPasswordViewModel
    private var navBarBehavior: HerfetyNavigationController?
    var cancelabel = Set<AnyCancellable>()
    weak var coordinator: ForgetPasswordTransitonDelegate?
    weak var alertPresenter: AlertPresenter?
    // MARK: - Init
    init(viewModel: ForgetPasswordViewModel) {
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
        usernameTextField.textfield.delegate = self
        currentPasswordTextField.textfield.delegate = self
        newPasswordTextField.textfield.delegate = self
        confirmPasswordTextField.textfield.delegate = self
        dismissKeyboardWhenTapped()

    }
    private func dismissKeyboardWhenTapped() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )
        tapGesture.cancelsTouchesInView = false  /// Allows other taps (e.g. buttons) to still work
        view.addGestureRecognizer(tapGesture)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    // MARK: - UI Setup
    /// NavBar
    private func setUpNavigationBar() {
        navBarBehavior = HerfetyNavigationController(
            navigationItem: navigationItem,
            navigationController: navigationController
        )
        navBarBehavior?.configure(
            title: "",
            titleColor: Colors.primaryBlue,
            onPlus: {
                /// don't add plus button in loginVC
            },
            showRighBtn: false,
            showBackButton: true) { [weak self] in
                self?.coordinator?.backToLoginVC()
            }
    }
    /// Configures the initial appearance of UI elements
    private func configureViews() {
        view.backgroundColor = Colors.hBackgroundColor

        // Images UI
        logoImage.image = Images.logo

        // Buttons UI
        resetBtn.title = "Reset Password"

        configureUsernameTextField()
        configurePasswordTextField()
        configureLabelsUI()
    }
    /// Configures username text field with title and placeholder
    private func configureUsernameTextField() {

        usernameTextField.title = "User Name"
        usernameTextField.placeholder = "Enter your name here"
        usernameTextField.textfield.addTarget(
            self,
            action: #selector(textDidChange),
            for: .editingChanged
        )
    }
    /// Configures password text field with title and placeholder
    private func configurePasswordTextField() {
        // Password TextField UI
        currentPasswordTextField.title = "Current Password"
        currentPasswordTextField.placeholder = "*******"
        currentPasswordTextField.textfield.addTarget(
            self,
            action: #selector(textDidChange),
            for: .editingChanged
        )
        newPasswordTextField.title = "New Password"
        newPasswordTextField.placeholder = "*******"
        newPasswordTextField.textfield.addTarget(
            self,
            action: #selector(textDidChange),
            for: .editingChanged
        )
        // Confirm Password TextField UI
        confirmPasswordTextField.title = "Confirm Password"
        confirmPasswordTextField.placeholder = "*******"
        confirmPasswordTextField.textfield.addTarget(
            self,
            action: #selector(textDidChange),
            for: .editingChanged
        )
    }

    /// Configures appearance of labels
    private func configureLabelsUI() {
        titleLabel.text = "Forget the password"
        titleLabel.textColor = Colors.primaryBlue

        subtitleLabel.text = "Change Password"
        subtitleLabel.textColor = Colors.hSocialButton
    }
}
// MARK: - Binding
//
extension ForgetPasswordViewController {
    private func bindViewModel() {
        viewModel
            .onSuccess
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
            self?.coordinator?.goToSuccessVC()
        }.store(in: &cancelabel)
        
        viewModel
            .onError
            .receive(on: DispatchQueue.main)
            .sink { [weak self] alert in
                self?.alertPresenter?.showAlert(alert)
            }.store(in: &cancelabel)

        viewModel.configureOnButtonEnabled { [weak self] isEnabled in
            self?.resetBtn.isEnabled = isEnabled
            self?.resetBtn.alpha = isEnabled ? 1.0 : 0.5
        }
    }
}
// MARK: - Actions
//
extension ForgetPasswordViewController {
    @IBAction func resetPassword(_ sender: Any) {
        Task {
            await viewModel.resetTapped()
        }
    }
}
// MARK: - TextFieldDelegate
//
extension ForgetPasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case usernameTextField.textfield:
            currentPasswordTextField.textfield.becomeFirstResponder()
        case currentPasswordTextField.textfield:
            newPasswordTextField.textfield.becomeFirstResponder()
        case newPasswordTextField.textfield:
            confirmPasswordTextField.textfield.becomeFirstResponder()
        case confirmPasswordTextField.textfield:
            confirmPasswordTextField.textfield.resignFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}
// MARK: - Private Handlers
//
extension ForgetPasswordViewController {
    @objc func textDidChange(_ sender: UITextField) {
        guard let text = sender.text else { return }

        if sender == usernameTextField.textfield {
            viewModel.userNameSubject.send(text)
        } else if sender == currentPasswordTextField.textfield {
            viewModel.currentPasswordSubject.send(text)
        } else if sender == newPasswordTextField.textfield {
            viewModel.newPasswordSubject.send(text)
        } else if sender == confirmPasswordTextField.textfield {
            viewModel.confirmPasswordSubject.send(text)
        }
    }
}
