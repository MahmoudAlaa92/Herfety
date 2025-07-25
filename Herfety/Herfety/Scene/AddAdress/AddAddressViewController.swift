import Combine
//
//  AddAdressViewController.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 17/02/2025.
//
import UIKit

class AddAddressViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var nameTextField: AddressTextField!
    @IBOutlet weak var addressTextField: AddressTextField!
    @IBOutlet weak var phoneTextField: AddressTextField!
    @IBOutlet weak var addButton: PrimaryButton!

    // MARK: - Properties
    private var navigationBarBehavior: HerfetyNavigationController?
    private var cancellables = Set<AnyCancellable>()
    ///
    var viewModel: AddAddressViewModel
    weak var coordinator: AddAddressChildDelegate?
    weak var alertPresenter: AlertPresenter?
    
    // MARK: - Init
    init(viewModel: AddAddressViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifcycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setUpNavigationBar()
        bindViewModel()
        configureTextFields()
    }
}
// MARK: - Configuration
//
extension AddAddressViewController {
    /// Set up Navigation Bar
    private func setUpNavigationBar() {
        navigationBarBehavior = HerfetyNavigationController(
            navigationItem: navigationItem,
            navigationController: navigationController
        )

        navigationBarBehavior?.configure(
            title: "Add Address",
            titleColor: .primaryBlue,
            onPlus: {
                /// plus button not appear in this VC
            },
            showRighBtn: false,
            showBackButton: true
        ) { [weak self] in
            self?.coordinator?.backToInfoVC()
        }
    }
    /// UI
    private func configureUI() {
        addButton.title = "Add"
        navigationItem.title = "Add Information"

    }
    private func configureTextFields() {
        nameTextField.placeholder = "Enter your name"
        addressTextField.placeholder = "Enter your address"
        phoneTextField.placeholder = "Enter your phone"

        nameTextField.textField.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
        addressTextField.textField.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
        phoneTextField.textField.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
    }
}
// MARK: - Actions
//
extension AddAddressViewController {
    @IBAction func addPressed(_ sender: Any) {
        viewModel.addButtonTapped()
    }
    
    @objc private func textDidChange(_ sender: UITextField) {
        if sender == nameTextField.textField {
            viewModel.updateName(sender.text ?? "")
        } else if sender == addressTextField.textField {
            viewModel.updateAddress(sender.text ?? "")
        } else if sender == phoneTextField.textField {
            viewModel.updatePhone(sender.text ?? "")
        }
    }
}
// MARK: - Binding
//
extension AddAddressViewController {
    private func bindViewModel() {
        viewModel.isAddButtonEnabled
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isEnabled in
                self?.addButton.isEnabled = isEnabled
                self?.addButton.alpha = isEnabled ? 1.0 : 0.6
            }
            .store(in: &cancellables)

        viewModel.success
            .sink { [weak self] in
                self?.coordinator?.backToInfoVC()
            }
            .store(in: &cancellables)

        viewModel.showAlert
            .sink { [weak self] alert in
                self?.alertPresenter?.showAlert(alert)
            }
            .store(in: &cancellables)
    }
}
