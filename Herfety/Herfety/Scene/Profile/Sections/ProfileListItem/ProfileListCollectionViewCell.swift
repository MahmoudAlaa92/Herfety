//
//  RowProfileCollectionViewCell.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 05/03/2025.
//

import UIKit

class ProfileListCollectionViewCell: UICollectionViewCell {
   // MARK: - ProPreties
    static let identifier: String = "ProfileListCollectionViewCell"
   // MARK: - Outlets
    @IBOutlet weak var imageOfView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configurUI()
    }
    
}
// MARK: - Configuration
//
extension ProfileListCollectionViewCell {
    private func configurUI() {
        nameLabel.textColor = Colors.primaryBlue
        nameLabel.font = .calloutBold
        
        languageLabel.font = .caption1
        languageLabel.textColor = Colors.labelGray
    }
}
// MARK: - Actions
//
extension ProfileListCollectionViewCell {
    @IBAction func pressedButton(_ sender: Any) {
    }
}
