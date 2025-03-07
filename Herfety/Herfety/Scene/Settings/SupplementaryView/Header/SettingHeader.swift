//
//  SettingHeader.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 07/03/2025.
//

import UIKit

class SettingHeader: UICollectionReusableView {

    @IBOutlet weak var imageSetting: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var editImage: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
   
}
// MARK: - Actions
//
extension SettingHeader {
    @IBAction func editImagePressed(_ sender: Any) {
        print("Edit Image")
    }
}
// MARK: - Configuration
//
extension SettingHeader {
    
    private func configureUI() {
        titleLabel.textColor = Colors.primaryBlue
        titleLabel.font = .calloutBold
    }
}
