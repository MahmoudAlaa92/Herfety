//
//  SettingFooter.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 07/03/2025.
//

import UIKit

class SettingFooter: UICollectionReusableView {
    
    // MARK: - Properties
    static let identifier: String = "SettingFooter"
    private var selectedGenderButton: GenderButton?
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var maleBtn: GenderButton!
    @IBOutlet weak var femaleBtn: GenderButton!
    @IBOutlet weak var settingTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
}
// MARK: - Configuration
//
extension SettingFooter {
    private func configureUI() {
        titleLabel.text = "Gender"
        titleLabel.font = .body
        titleLabel.textColor = Colors.hCardTextFieldPlaceholder
        
        settingTitle.text = "Setting"
        settingTitle.font = .title3
        settingTitle.textColor = Colors.primaryBlue
        
        maleBtn.layer.cornerRadius = 8
        maleBtn.layer.masksToBounds = true
        maleBtn.delegate = self
        
        femaleBtn.layer.cornerRadius = 8
        femaleBtn.layer.masksToBounds = true
        femaleBtn.delegate = self
    }
}
// MARK: - Delegate
//
extension SettingFooter:GenderButtonDelegate {
    func didTapGenderButton(_ button: GenderButton) {
        
        if selectedGenderButton == button { return }
        
        /// Deselect the previously selected button
        selectedGenderButton?.updateSelection(isSelected: false)
        
        /// Select the new button
        selectedGenderButton = button
        selectedGenderButton?.updateSelection(isSelected: true)
    }
}
// MARK: - Actions
//
extension SettingFooter {
    @IBAction func malePressed(_ sender: Any) {
    }
    
    @IBAction func femalePressed(_ sender: Any) {
    }
}
