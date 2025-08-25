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
    // MARK: - Properties
    private var viewModel: SuccessViewModelType
    weak var coordinator: SuccessTransitionDelegate?
    
    // MARK: - Init
    init(viewModel: SuccessViewModelType) {
        self.viewModel = viewModel
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
}
// MARK: - Setup UI
//
extension SuccessViewController {
    private func setupUI() {
        view.backgroundColor = Colors.hPrimaryBackground
        containerView.backgroundColor = Colors.hPrimaryBackground
        
        /// Labels UI
        successLabel.text = L10n.Auth.Success.title
        successLabel.textColor = Colors.primaryBlue
        
        successMessage.text = L10n.Auth.Success.message
        successMessage.textColor = Colors.hSocialButton
        
        /// Images UI
        imageView.image = Images.iconSuccess
        
        /// Buttons UI
        startButton.title = L10n.Auth.Success.startShopping
    }
}
// MARK: - Actions
//
extension SuccessViewController {
    @IBAction func startShoppingButtonTapped(_ sender: UIButton) {
        dismiss(animated: true) { [weak self] in
            self?.viewModel.startShoppingTapped()
        }
    }
}
