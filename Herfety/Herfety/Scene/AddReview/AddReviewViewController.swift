//
//  AddAdressViewController.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 17/02/2025.
//
import UIKit
import Combine

class AddReviewViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var AddReviewTextField: AddressTextField!
    @IBOutlet weak var ratingTextField: AddressTextField!
    @IBOutlet weak var addButton: PrimaryButton!
    
    // MARK: - Properties
    var viewModel: AddReviewViewModel
    private var navBarBehavior: HerfetyNavigationController?
    private var cancellables = Set<AnyCancellable>()
    weak var coordinator: AddReviewsChildDelegate?
    weak var alertPresenter: AlertPresenter?
    
    // MARK: - Init
    init(viewModel: AddReviewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Lifcycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        configureUI()
        setUpuNavigationBar()
        configureTextFields()
        bindViewModel()
    }
}
// MARK: - Configuration
//
extension AddReviewViewController {
    /// NavBar
    private func setUpNavigationBar() {
        navBarBehavior = HerfetyNavigationController(
            navigationItem: navigationItem,
            navigationController: navigationController
        )
        navBarBehavior?.configure(
            title: "",
            titleColor: Colors.primaryBlue,
            onPlus: {
                /// don't add plus button in VC
            },
            showRighBtn: false,
            showBackButton: true,  /// Enable back button
            onBack: { [weak self] in
                self?.coordinator?.backToReviewersVC()
            }
        )
    }
    /// UI
    private func configureUI() {
        addButton.title = "Add"
    }
    /// Navigation Bar
    private func setUpuNavigationBar() {
        navigationItem.title = "Add Review"
    }
    /// Text Feild
    private func configureTextFields() {
        AddReviewTextField.placeholder = "Enter your Comment"
        AddReviewTextField.textField.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
        
        ratingTextField.textField.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
        ratingTextField.placeholder = "Rating (1-5)"
        ratingTextField.textField.keyboardType = .numberPad
    }
}
// MARK: - Actions
//
extension AddReviewViewController {
    @objc private func textDidChange(_ sender: UITextField) {
        if sender == AddReviewTextField.textField {
            viewModel.updateReviewText(sender.text ?? "")
        }else if sender == ratingTextField.textField {
            viewModel.updateRating(sender.text ?? "")
        }
    }
    @IBAction func addPressed(_ sender: Any) {
        viewModel.addButtontapped()
    }
}
// MARK: - Binding
//
extension AddReviewViewController {
    private func bindViewModel() {
        
        viewModel.isAddButtonEnabled
            .sink { [weak self] isEnabled in
                self?.addButton.isEnabled = isEnabled
                self?.addButton.alpha = isEnabled ? 1.0 : 0.6
            }
            .store(in: &cancellables)
        
        viewModel.showAlert
            .sink { [weak self] alert in
                self?.alertPresenter?.showAlert(alert)
            }
            .store(in: &cancellables)
        
        viewModel.isSuccess.sink { [weak self] in
            self?.coordinator?.backToReviewersVC()
        }.store(in: &cancellables)
        
    }
}
