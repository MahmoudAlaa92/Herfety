//
//  AddressTextField.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 17/02/2025.
//

import UIKit

class AddressTextField: UIView {
    // MARK: - Outlets
    @IBOutlet weak var textField: UITextField!
    
    // MARK: - Propereties
    var placeholder: String? {
        get { textField.placeholder }
        set {
            textField.placeholder = newValue
            // add font and color from extension
        }
    }
    
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
        textField.heightAnchor.constraint(equalToConstant: 56).isActive = true
        layer.cornerRadius = 15
        layer.borderWidth = 0.5
        layer.borderColor = Colors.hCardTextFieldPlaceholder.cgColor
    }
}

