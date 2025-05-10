//
//  SignupViewController.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 7/04/2025.
//

import UIKit

class SignupViewController: UIViewController {
    
    // MARK: - Outlets
    
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
        configurePhoneTextField()
        configureLabelsUI()
    }
    
    /// Configures username text field with title and placeholder
    private func configureUsernameTextField() {
        firstNameTextField.title = "First name"
        firstNameTextField.placeholder = "Enter your First name"
        
        lastNameTextField.title = "Last name"
        lastNameTextField.placeholder = "Enter your last name"
        
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
    
    @IBAction func loginTapped(_ sender: Any) {
        
//        let register: RegisterRemoteProtocol = RegisterRemote(network: AlamofireNetwork())
//        register.registerUser(user: RegisterUser(
//            firstName: "Mahmoud",
//            lastName:  "aa",
//            userName:  "MahmoudA",
//            password:  "1234567",
//            confirmPassword: "1234567",
//            email: "mahmmoudaa@gmail.com",
//            phone:  "01142128919",
//            image: "")) { result in
//                switch result {
//                case .success(let value):
//                    print("Succes is \(value)")
//                    let vc = SuccessViewController()
//                    vc.modalPresentationStyle = .fullScreen
//                    
//                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//                       let window = windowScene.windows.first {
//                        window.rootViewController = vc
//                        window.makeKeyAndVisible()
//                    }
//                case .failure(let error):
//                    print(error)
//                    let alertItem = AlertModel(
//                        message: "Error in registration",
//                        buttonTitle: "Ok",
//                        image: .warning,
//                        status: .error
//                    )
//                    self.presentCustomAlert(with: alertItem)
//                }
//            }
        // Safely unwrap and validate input
//           guard
//            let firstName = firstNameTextField.textfield.text, !firstName.isEmpty,
//            let lastName = lastNameTextField.textfield.text, !lastName.isEmpty,
//            let username = usernameTextField.textfield.text, !username.isEmpty,
//            let email = emailTextField.textfield.text, !email.isEmpty,
//            let password = passwordTextField.textfield.text, !password.isEmpty,
//            let confirmPassword = confirmPasswordTextField.textfield.text, !confirmPassword.isEmpty,
//            let phone = phoneNumber.textfield.text, !phone.isEmpty else {
//               let alertItem = AlertModel(
//                   message: "All fields are required.",
//                   buttonTitle: "Ok",
//                   image: .warning,
//                   status: .error
//               )
//               presentCustomAlert(with: alertItem)
//               return
//           }

           // Create RegisterUser model
           let user = RegisterUser(
               FName: "Mahmoudd",
               LName: "Alaa",
               UserName: "MahmoudAlaa",
               Password: "1234567",
               ConfirmPassword: "1234567",
               Email: "MahmoudAlaa1000@gmail.com",
               Phone: "01242128919",
               image: "url"
           )
        do {
            let jsonData = try JSONEncoder().encode(user)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print("📦 JSON Payload: \(jsonString)")
            }
        } catch {
            print("❌ Encoding Error: \(error.localizedDescription)")
        }

           // Call the register function
           let register: RegisterRemoteProtocol = RegisterRemote(network: AAlamofireNetwork())
           register.registerUser(user: user) { result in
               DispatchQueue.main.async {
                   switch result {
                   case .success(let response):
                       print("✅ Registration Success: \(response)")
                       let vc = SuccessViewController()
                       vc.modalPresentationStyle = .fullScreen
                       if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                          let window = windowScene.windows.first {
                           window.rootViewController = vc
                           window.makeKeyAndVisible()
                       }

                   case .failure(let error):
                       print("❌ Registration Failed: \(error.localizedDescription)")
                       let alertItem = AlertModel(
                           message: "Registration failed. Please try again.",
                           buttonTitle: "Ok",
                           image: .warning,
                           status: .error
                       )
                       self.presentCustomAlert(with: alertItem)
                   }
               }
           }
    }
}

extension SignupViewController {
    func presentCustomAlert(with alertItem: AlertModel) {
        let alertVC = AlertViewController(nibName: "AlertViewController", bundle: nil)
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        alertVC.loadViewIfNeeded() /// Ensure outlets are connected
        
        alertVC.show(alertItem: alertItem)
        
        /// Optional: dismiss on button press
        alertVC.actionHandler = { [weak alertVC] in
            alertVC?.dismiss(animated: true)
        }
        self.present(alertVC, animated: true)
    }
}

import Alamofire

protocol RegisterRemoteProtocol {
    func registerUser(user: RegisterUser, completion: @escaping (Result<Registration, Error>) -> Void)
}

class RegisterRemote: RegisterRemoteProtocol {
    private let network: NetworkServiceProtocol

    init(network: NetworkServiceProtocol) {
        self.network = network
    }

    func registerUser(user: RegisterUser, completion: @escaping (Result<Registration, Error>) -> Void) {
        let url = "https://harfty.runasp.net/api/RegisterUser/Register"
        
        network.postRequest(url: url, parameters: user, completion: completion)
    }
}

protocol NetworkServiceProtocol {
    func postRequest<T: Codable, U: Codable>(
        url: String,
        parameters: T,
        completion: @escaping (Result<U, Error>) -> Void
    )
}

class AAlamofireNetwork: NetworkServiceProtocol {
    func postRequest<T: Codable, U: Codable>(
        url: String,
        parameters: T,
        completion: @escaping (Result<U, Error>) -> Void
    ) {
        AF.upload(
            multipartFormData: { multipartFormData in
                // Convert parameters to a dictionary
                let mirror = Mirror(reflecting: parameters)
                for child in mirror.children {
                    if let key = child.label, let value = child.value as? String {
                        multipartFormData.append(Data(value.utf8), withName: key)
                    }
                }
            },
            to: url,
            method: .post
        )
        .validate()
        .responseDecodable(of: U.self) { response in
            switch response.result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
