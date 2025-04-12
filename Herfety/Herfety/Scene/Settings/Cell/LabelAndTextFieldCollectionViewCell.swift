//
//  LabelAndTextFieldCollectionViewCell.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 02/04/2025.
//

import UIKit

class LabelAndTextFieldCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties
    static let identifier: String = "LabelAndTextFieldCollectionViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
}
// MARK: - Configuration
//
extension LabelAndTextFieldCollectionViewCell {
    private func configureUI() {
        /// nameLabel
        nameLabel.font = .body
        nameLabel.textColor = Colors.hCardTextFieldPlaceholder
        /// textField
        textField.layer.cornerRadius = 12
        textField.layer.masksToBounds = true
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = Colors.labelGray.cgColor
    }
}
