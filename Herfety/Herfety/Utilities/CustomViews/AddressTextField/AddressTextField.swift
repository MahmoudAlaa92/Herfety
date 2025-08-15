//
//  AddressTextField.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 17/02/2025.
//

import UIKit

protocol AddressTextFieldDelegate: AnyObject {
    func addressTextFieldDidChange(_ textField: AddressTextField, textDidChange: String?)
}

class AddressTextField: UIView, UITextFieldDelegate {
    // MARK: - Outlets
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var textField: UITextField!
    weak var delegate: AddressTextFieldDelegate?
    
    // MARK: - Propereties
    var placeholder: String? {
        get { textField.placeholder }
        set {
            textField.placeholder = newValue
            // add font and color from extension
        }
    }
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNib()
        configureUI()
    }

    private func loadNib() {
        /// Loads the view from a nib file and adds it as a subview.
        if let view = Bundle.main.loadNibNamed(String(describing: Self.self), owner: self, options: nil)?.first as? UIView {
            addSubview(view)
            view.frame = bounds
        }
    }
}

// MARK: - Configuration
//
extension AddressTextField {
  
    private func configureUI() {
        setUpTextField()
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
        textField.delegate = self
        textField.heightAnchor.constraint(equalToConstant: 56).isActive = true
        layer.cornerRadius = 15
        layer.borderWidth = 0.5
        layer.borderColor = Colors.hCardTextFieldPlaceholder.cgColor
    }
}
// MARK: - Actions
//
extension AddressTextField {
    
    func setUpTextField() {
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        delegate?.addressTextFieldDidChange(self, textDidChange: textField.text)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
