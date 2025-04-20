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
    @IBOutlet weak var signupButton: PrimaryButton!
    @IBOutlet weak var HerfetyView: LottieAnimationView!
    // MARK: - Properties
    private var navigationBarBehavior: InfoNavBar?
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
        navigationItem.backButtonTitle = ""
        setUpNavigationBar()
        setup()
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
        signupButton.title = "SignUp"
        loginButton.title = "Login"
    }
}
// MARK: - Configuration
//
extension SplashViewController {
    /// Set up Navigation Bar
    private func setUpNavigationBar() {
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.layer.shadowColor = UIColor.clear.cgColor
        navigationController?.navigationBar.layer.shadowOpacity = 0
        ///
        navigationBarBehavior = InfoNavBar(navigationItem: navigationItem, navigationController: navigationController)
        navigationBarBehavior?.configure(title: "", titleColor: Colors.primaryBlue, onPlus: {
            
        }, showRighBtn: false)
    }
}
// MARK: - Actions
//
extension SplashViewController {
    @IBAction func loginPressed(_ sender: Any) {
        let vc = LoginViewController(viewModel: LoginViewModel())
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
