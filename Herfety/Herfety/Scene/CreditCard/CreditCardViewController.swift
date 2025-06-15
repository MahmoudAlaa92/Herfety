//
//  CreditCardViewController.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 20/02/2025.
//

import UIKit

class CreditCardViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var headerCard: UILabel!
    @IBOutlet weak var addNewCardLabel: UILabel!
    @IBOutlet weak var cardView: CardView!
    @IBOutlet weak var cardDetailsLabel: UILabel!
    
    @IBOutlet weak var headerTextField: UILabel!
    @IBOutlet weak var cardNumberTextField: AddressTextField!
    @IBOutlet weak var cardHolderNameTextField: AddressTextField!
    @IBOutlet weak var cardExpDateTextField: AddressTextField!
    @IBOutlet weak var cardCvvTextField: AddressTextField!
    
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var confirmBtn: PrimaryButton!
    
    // MARK: - Properties
    var viewModel: CreditCardViewModel
    // MARK: - Init
    init(viewModel: CreditCardViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = CreditCardViewModel()
        super.init(coder: coder)
    }
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        cofigureTextFieldsPlaceHolder()
        configureHeaderLabel()
        configureButtonUI()
        setUpDelegates()
        bindViewModel()
    }
    // Bind
    private func bindViewModel() {
        
        viewModel.onCardNumberChange = { [weak self] value in
            self?.cardNumberTextField.textField.text = value
            self?.cardView.setCardNumber(number: value)
        }
        
        viewModel.onCardHolderChange = { [weak self] value in
            self?.cardView.setCardHolderName(name: value)
        }
        
        viewModel.onCVVChange = { [weak self] value in
            self?.cardCvvTextField.textField.text = self?.viewModel.isValidTextField(value: value, 3)
        }
        
        viewModel.onExpDateChange = { [weak self] value in
            let validValue = self?.viewModel.formatExpirationDate(value)
            self?.cardExpDateTextField.textField.text = validValue
            self?.cardView.setValueDate(date: validValue ?? "")
        }
        
        viewModel.onDismiss = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
    }
    
}

// MARK: - Configuration
//
extension CreditCardViewController {
    
    private func configureHeaderLabel() {
        headerCard.font = .title2
        headerTextField.font = .title2
    }
    
    private func cofigureTextFieldsPlaceHolder () {
        addNewCardLabel.text = "Add New Card"
        addNewCardLabel.font = .title3
        
        cardDetailsLabel.text = "Card Details"
        cardDetailsLabel.font = .title3
        
        cardNumberTextField.placeholder = "Card Number"
        cardHolderNameTextField.placeholder = "Card holder Name"
        cardExpDateTextField.placeholder = "Exp Date"
        cardCvvTextField.placeholder = "CVV"
    }
    
    private func configureButtonUI() {
        confirmBtn.title = "Confirm"
        if #available(iOS 15.0, *) {
            cancelBtn.configuration = nil
            cancelBtn.setTitle("Cancel", for: .normal)
            cancelBtn.setTitleColor(Colors.hCardTextFieldPlaceholder, for: .normal)
            cancelBtn.titleLabel?.font = .callout
        }
    }
    
    private func setUpDelegates() {
        cardNumberTextField.delegate = self
        cardHolderNameTextField.delegate = self
        cardExpDateTextField.delegate = self
        cardCvvTextField.delegate = self
    }
}

// MARK: - TextFieldDelegates
//
extension CreditCardViewController: AddressTextFieldDelegate {
    func addressTextFieldDidChange(_ textField: AddressTextField, textDidChange: String?) {
        guard let text = textDidChange else { return }
        
        switch textField {
        case cardNumberTextField:
            viewModel.onCardNumberChange?(viewModel.isValidTextField(value: text, 16))
        case cardHolderNameTextField:
            viewModel.onCardHolderChange?(text)
        case cardExpDateTextField:
            viewModel.onExpDateChange?(viewModel.formatExpirationDate(text))
        case cardCvvTextField:
            viewModel.onCVVChange?(viewModel.isValidTextField(value: text, 3))
        default:
            break
        }
    }
}
// MARK: - Actions
//
extension CreditCardViewController {
    
    
    @IBAction func cancelPressed(_ sender: Any) {
        viewModel.didTapCancel()
    }
    
    @IBAction func confirmPressed(_ sender: Any) {
        print("Confirm pressed")
        viewModel.didTapAddCard()
        
    }
}
