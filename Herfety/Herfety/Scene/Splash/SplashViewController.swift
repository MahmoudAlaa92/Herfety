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
    private let viewModel: SplashViewModel
    weak var coordinator: SplashTransitionDelegate?
    // MARK: - Init
    init(viewModel:SplashViewModel) {
        self.viewModel = viewModel
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
    /// NavBar
    private func setUpNavigationBar() {
        navigationItem.backButtonTitle = ""
        navigationBarBehavior = HerfetyNavigationController(
            navigationItem: navigationItem,
            navigationController: navigationController
        )
        navigationBarBehavior?.configure(
            title: "",
            titleColor: Colors.primaryBlue,
            onPlus: {
                /// don't add plus button in loginVC
            },
            showRighBtn: false,
            showBackButton: false)
    }
}
// MARK: - Actions
//
extension SplashViewController {
    
    @IBAction func loginPressed(_ sender: Any) {
        coordinator?.goLoginVC()
    }
    
    @IBAction func signUpPressed(_ sender: Any) {
        coordinator?.goSignUpVC()
    }
}
