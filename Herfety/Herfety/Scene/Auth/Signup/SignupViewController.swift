//
//  SignupViewController.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 7/04/2025.
//

import UIKit

class SignupViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var usernameTextField: HRTextField!
    @IBOutlet weak var emailTextField: HRTextField!
    @IBOutlet weak var passwordTextField: HRTextField!
    @IBOutlet weak var confirmPasswordTextField: HRTextField!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var loginButton: PrimaryButton!
    
    // MARK: - Life Cycle Methods
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = ""
        configureViews()
    }
    
    // MARK: - UI Setup
    
    /// Configures the initial appearance of UI elements
    private func configureViews() {
        view.backgroundColor = Colors.hBackgroundColor
        
        // Images UI
        logoImage.image = Images.logo
        
        // Buttons UI
        loginButton.title = "login"
        
        configureUsernameTextField()
        configureEmailTextField()
        configurePasswordTextField()
        configureLabelsUI()
    }
    
    /// Configures username text field with title and placeholder
    private func configureUsernameTextField() {
        usernameTextField.title = "User Name"
        usernameTextField.placeholder = "Enter your name here"
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
    
    /// Configures appearance of labels
    private func configureLabelsUI() {
        titleLabel.text = "Sign Up"
        titleLabel.textColor = Colors.primaryBlue
        
        subtitleLabel.text = "Create an new account"
        subtitleLabel.textColor = Colors.hSocialButton
    }
}
