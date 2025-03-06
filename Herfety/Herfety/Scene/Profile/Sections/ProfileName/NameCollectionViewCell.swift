//
//  NameCollectionViewCell.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 05/03/2025.
//

import UIKit

class NameCollectionViewCell: UICollectionViewCell {

    static let identifier = "NameCollectionViewCell"
    // MARK: - Outlets
    //
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var nameProfile: UILabel!
    @IBOutlet weak var emailProfile: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureIU()
    }

}
// MARK: - Configurations
//
extension NameCollectionViewCell {
    private func configureIU() {
        nameProfile.font = .title3
        
        emailProfile.font = .caption1
        emailProfile.textColor = Colors.hCardTextFieldPlaceholder
        
        /// Shadow
        backView.backgroundColor = Colors.hMainTheme
        backView.layer.shadowColor = Colors.primaryBlue.cgColor
        backView.layer.shadowOffset = .zero
        backView.layer.shadowRadius = 2
        backView.layer.shadowOpacity = 0.15
        backView.layer.cornerRadius = 13
    }
}
