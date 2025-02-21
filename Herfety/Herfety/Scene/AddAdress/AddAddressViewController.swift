//
//  AddAdressViewController.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 17/02/2025.
//

import UIKit

protocol AddAddressViewControllerDelegate: AnyObject {
    func didAddAddress(_ address: InfoModel)
}

class AddAddressViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var nameTextField: AddressTextField!
    @IBOutlet weak var addressTextField: AddressTextField!
    @IBOutlet weak var phoneTextField: AddressTextField!
    @IBOutlet weak var addButton: PrimaryButton!
    
    // MARK: - Properties
    var viewModel:AddAddressViewModel
    weak var delegate: AddAddressViewControllerDelegate?
    
    // MARK: - Init
    init(viewModel:AddAddressViewModel) {
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
        setUpuNavigationBar()
        configureTextFieldsPlaceholder()
    }
}

// MARK: - Configuration
//
extension AddAddressViewController {
    
    // UI
    private func configureUI() {
        addButton.title = "Add"
    }
    // Navigation Bar
    private func setUpuNavigationBar() {
        navigationItem.title = "Add Information"
    }
    // Text Feild
    private func configureTextFieldsPlaceholder() {
        nameTextField.placeholder = "Enter your name"
        addressTextField.placeholder = "Enter your address"
        phoneTextField.placeholder = "Enter your phone"
    }
}

// MARK: - Actions
//
extension AddAddressViewController {
    @IBAction func addPressed(_ sender: Any) {
        guard let name = nameTextField.textField.text, !name.isEmpty,
              let phone = phoneTextField.textField.text, !phone.isEmpty,
              let address = addressTextField.textField.text, !address.isEmpty
        else{
            return
        }
        delegate?.didAddAddress(InfoModel(name: name, address: address, phone: phone))
        self.navigationController?.popViewController(animated: true)
    }
}
