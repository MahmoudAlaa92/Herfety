//
//  LoginViewController.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 20/04/2024.
//
import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var emailTextField: HRTextField!
    @IBOutlet weak var passwordTextField: HRTextField!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var loginButton: PrimaryButton!
    @IBOutlet weak var facebookButton: FacebookButton!
    @IBOutlet weak var appleButton: AppleButton!
    @IBOutlet weak var googleButton: GoogleButton!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var orLabel: UILabel!
    
    // MARK: - Properties
    let viewModel: LoginViewModel
    // MARK: - Init
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = ""
        configureViews()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        /// Keep nav bar visible
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        /// hide the line
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.shadowColor = nil /// removes the bottom line
        appearance.backgroundColor = .systemBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black, .font: UIFont.title2]
        
        // Optional: If you have a custom back button image
        appearance.setBackIndicatorImage(
            Images.iconBack.withRenderingMode(.alwaysOriginal),
            transitionMaskImage: Images.iconBack.withRenderingMode(.alwaysOriginal)
        )
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    // MARK: - UI Setup
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
    }
    /// Configures email text field with title and placeholder
    private func configureEmailTextField() {
        emailTextField.title = "Email"
        emailTextField.placeholder = "MahmoudAlaa.wr@gmail.com"
    }
    /// Configures password text field with title and placeholder
    private func configurePasswordTextField() {
        passwordTextField.title = "Password"
        passwordTextField.placeholder = "*******"
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
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
        viewModel.loginButtonTapped()
    }
}
