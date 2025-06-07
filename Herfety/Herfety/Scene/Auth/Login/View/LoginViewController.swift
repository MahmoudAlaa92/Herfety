//
//  LoginViewController.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 20/04/2024.
//
import UIKit
import Firebase
import FirebaseAuth
import FacebookLogin
import GoogleSignIn

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
        emailTextField.placeholder = "MahmoudAlaa"
        emailTextField.textfield.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
    }
    /// Configures password text field with title and placeholder
    private func configurePasswordTextField() {
        passwordTextField.title = "Password"
        passwordTextField.placeholder = "*******"
        passwordTextField.textfield.isSecureTextEntry = true
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
          viewModel.onLoginTapped = { [weak self] in
              let vc = SuccessViewController()
              vc.modalPresentationStyle = .fullScreen
              self?.present(vc, animated: true)
          }
          
          viewModel.onError = { [weak self] errorMessage in
              let alert = UIAlertController(
                  title: "Login Failed",
                  message: errorMessage,
                  preferredStyle: .alert
              )
              alert.addAction(UIAlertAction(title: "OK", style: .default))
              self?.present(alert, animated: true)
          }
          
          viewModel.configureOnButtonEnabled { [weak self] isEnabled in
              self?.loginButton.isEnabled = isEnabled
              self?.loginButton.alpha = isEnabled ? 1.0 : 0.5
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
        
        
        let fbLoginManager = LoginManager()
        fbLoginManager.logIn(
            permissions: ["public_profile", "email"],
            from: self) { result, error in
                if let error = error {
                    print("Failed to login: \(error.localizedDescription)")
                    return
                }
                
                guard let accessToken = AccessToken.current else {
                    print("Failed to get access token")
                    return
                }
                
                let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
                
                // Perform Firebase login
                Auth.auth().signIn(with: credential) { authResult, error in
                    if let error = error {
                        if let errCode = AuthErrorCode(rawValue: error._code) {
                            if errCode == .accountExistsWithDifferentCredential {
                                // Handle the account exists with different credential error
                                guard let nsError = error as NSError? else { return }
                                guard let email = nsError.userInfo["FIRAuthErrorUserInfoEmailKey"] as? String else {
                                    print("No email found for this error.")
                                    return
                                }
                                
                                // Show an alert to guide the user
                                let alert = UIAlertController(
                                    title: "Account Exists",
                                    message: "An account already exists with this email address (\(email)). Please sign in with the correct provider (Google, email, etc.) and link your Facebook account from there.",
                                    preferredStyle: .alert
                                )
                                
                                let okAction = UIAlertAction(title: "OK", style: .default)
                                alert.addAction(okAction)
                                self.present(alert, animated: true)
                            }
                        } else {
                            // Handle other errors
                            print("Error when login: \(error.localizedDescription)")
                            
                            let alert = UIAlertController(
                                title: "Login Error",
                                message: error.localizedDescription,
                                preferredStyle: .alert
                            )
                            
                            let okAction = UIAlertAction(title: "OK", style: .cancel)
                            alert.addAction(okAction)
                            self.present(alert, animated: true)
                        }
                        return
                    }
                    
                    // Login successful
                    guard let user = authResult?.user else { return }
                    
                    print("user id: \(user.uid)\n Name: \(user.displayName)\n photoUrl\(user.photoURL)")
//                    DataPersistentManager.shared.userId = user.uid
//                    DataPersistentManager.shared.userName = user.displayName ?? "Guest"
//                    DataPersistentManager.shared.userImageURL = user.photoURL
//                    
//                    // Present the main view
//                    self.presentMainView()
                }
            }
    }
    
    @IBAction func googleTapped(_ sender: Any) {
        
        guard let clientID = FirebaseApp.app()?.options.clientID else{
            return
        }
        
        let configuration = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.configuration = configuration
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return
        }
        
        guard let rootVC = windowScene.windows.first?.rootViewController else {
            return
        }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: rootVC) { [unowned self] result, error in
            if let error = error {
                print("Login Error: \(error.localizedDescription)")
                
                let alert = UIAlertController(title: "Login Error",
                                              message: error.localizedDescription,
                                              preferredStyle: .alert)
                
                let okayAction = UIAlertAction(title: "OK", style: .cancel)
                alert.addAction(okayAction)
                self.present(alert, animated: true)
                
                return
            }
            
            // Get the Google ID token and Google access token
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString else {
                
                print("Error: Missing Google ID token")
                return
            }
            
            let accessToken = user.accessToken.tokenString
            
            // Get the Firebase credential using the Google tokens
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
            
            // Sign in with Firebase using the Google credential
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("Firebase login error: \(error.localizedDescription)")
                    
                    let alert = UIAlertController(title: "Login Error",
                                                  message: error.localizedDescription,
                                                  preferredStyle: .alert)
                    
                    let okayAction = UIAlertAction(title: "OK", style: .cancel)
                    alert.addAction(okayAction)
                    self.present(alert, animated: true)
                    return
                }
                
                // Successfully signed in
                if let authResult = authResult {
                    let user = authResult.user
                    print("user id: \(user.uid)\n Name: \(user.displayName)\n photoUrl\(user.photoURL)")

//                    DataPersistentManager.shared.userId = user.uid
//                    DataPersistentManager.shared.userName = user.displayName ?? "Geust"
//                    DataPersistentManager.shared.userImageURL = user.photoURL
//                    
//                    // Present main veiw
//                    self.presentMainView()
                }
            }
            
        }
    }
    
    @IBAction func appleTapped(_ sender: Any) {
    }
}
