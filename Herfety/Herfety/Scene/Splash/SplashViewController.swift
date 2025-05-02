//
//  SplashViewController.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 20/04/2025.
//
import UIKit
import Lottie

class SplashViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var loginButton: SecondaryButtonn!
    @IBOutlet weak var signUpButton: PrimaryButton!
    @IBOutlet weak var HerfetyView: LottieAnimationView!
    // MARK: - Properties
    private var navigationBarBehavior: HerfetyNavigationController?
    // MARK: - Init
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setUpNavigationBar()
        makeAnimation()
    }
    /// lottie Animation
    private func makeAnimation() {
        HerfetyView.animation = .named("HerfetyAnimation")
        HerfetyView.loopMode = .loop
        HerfetyView.play()
    }
    // MARK: - Setup Buttons
    private func setup() {
        loginButton.title = "Login"
        signUpButton.title = "SignUp"
    }
}
// MARK: - Configuration
//
extension SplashViewController {
    /// Set up Navigation Bar
    private func setUpNavigationBar() {
        navigationItem.backButtonTitle = ""
    }
}
// MARK: - Actions
//
extension SplashViewController {
    
    @IBAction func loginPressed(_ sender: Any) {
        let vc = LoginViewController(viewModel: LoginViewModel())
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func signUpPressed(_ sender: Any) {
    }
}
