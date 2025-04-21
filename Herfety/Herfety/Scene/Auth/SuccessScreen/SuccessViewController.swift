//
//  SuccessViewController.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 20/04/2025.
//
import UIKit

class SuccessViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet private(set) weak var containerView: UIView!
    @IBOutlet private(set) weak var successLabel: UILabel!
    @IBOutlet private(set) weak var successMessage: UILabel!
    @IBOutlet private(set) weak var imageView: UIImageView!
    @IBOutlet weak var startButton: PrimaryButton!
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
        setupUI()
    }
    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = Colors.hPrimaryBackground
        containerView.backgroundColor = Colors.hPrimaryBackground
        
        /// Labels UI
        successLabel.text = "Successful!"
        successLabel.textColor = Colors.primaryBlue
        
        successMessage.text = "You have successfully registered in\nour app and start working in it."
        successMessage.textColor = Colors.hSocialButton
        
        // Images UI
        imageView.image = Images.iconSuccess
        
        // Buttons UI
        startButton.title = "Start Shopping"
    }
    @IBAction func startShoppingButtonTapped(_ sender: UIButton) {
        let customTabBar =  CustomeTabBarViewController()
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController = customTabBar
            window.makeKeyAndVisible()
        }
    }
}
