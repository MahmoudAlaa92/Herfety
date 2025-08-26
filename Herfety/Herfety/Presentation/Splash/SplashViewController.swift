//
//  SplashViewController.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 20/04/2025.
//
import UIKit
import Combine
import Lottie

class SplashViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var loginButton: SecondaryButtonn!
    @IBOutlet weak var signUpButton: PrimaryButton!
    @IBOutlet weak var HerfetyView: LottieAnimationView!
    
    // MARK: - Properties
    private lazy var navigationBarBehavior = HerfetyNavigationController(
        navigationItem: navigationItem,
        navigationController: navigationController)
    private let viewModel: SplashViewModelType
    weak var coordinator: SplashTransitionDelegate?
    private var cancellabels = Set<AnyCancellable>()
    
    // MARK: - Init
    init(viewModel: SplashViewModelType) {
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
        bindViewModel()
    }
}
// MARK: - Configuration
//
extension SplashViewController {
    /// NavBar
    private func setUpNavigationBar() {
        navigationItem.backButtonTitle = ""
        navigationBarBehavior.configure(
            title: "",
            titleColor: Colors.primaryBlue,
            onPlus: {
                /// don't add plus button in loginVC
            },
            showRighBtn: false,
            showBackButton: false)
    }
    /// Setup Buttons
    private func setup() {
        loginButton.title = L10n.Auth.login
        signUpButton.title = L10n.Auth.signup
    }
}
// MARK: - Actions
//
extension SplashViewController {
    
    @IBAction func loginPressed(_ sender: Any) {
        viewModel.loginTapped()
    }
    
    @IBAction func signUpPressed(_ sender: Any) {
        viewModel.signUpTapped()
    }
}
// MARK: - Binding
//
extension SplashViewController {
    private func bindViewModel() {
        viewModel
            .onLogin
            .sink { [weak self] _ in
                self?.coordinator?.goLoginVC()
            }.store(in: &cancellabels)
        
        viewModel
            .onSignUp
            .sink { [weak self] _ in
                self?.coordinator?.goSignUpVC()
            }.store(in: &cancellabels)
    }
}
// MARK: - Private Handler
//
extension SplashViewController {
    /// lottie Animation
    private func makeAnimation() {
        HerfetyView.animation = .named(L10n.Auth.herfetyAnimation)
        HerfetyView.loopMode = .loop
        HerfetyView.play()
    }
}
