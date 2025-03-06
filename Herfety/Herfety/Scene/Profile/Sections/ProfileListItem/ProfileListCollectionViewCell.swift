//
//  RowProfileCollectionViewCell.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 05/03/2025.
//

import UIKit

class ProfileListCollectionViewCell: UICollectionViewCell {

    static let identifier: String = "ProfileListCollectionViewCell"
    
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
        nameLabel.font = .body
    }
}
// MARK: - Actions
//
extension ProfileListCollectionViewCell {
    @IBAction func pressedButton(_ sender: Any) {
    }
}
