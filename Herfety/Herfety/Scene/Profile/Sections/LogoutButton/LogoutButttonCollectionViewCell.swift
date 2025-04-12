//
//  LogoutButttonCollectionViewCell.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 12/04/2025.
//

import UIKit

class LogoutButttonCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    static let identifier = "LogoutButttonCollectionViewCell"
    // MARK: - Outlets
    @IBOutlet weak var logoutButton: HerfetyButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
// MARK: - Configurations
//
extension LogoutButttonCollectionViewCell {
    func configureButton(title: String, image: UIImage?) {
        logoutButton.title = title
        logoutButton.image = image
    }
}
// MARK: - Actions
//
extension LogoutButttonCollectionViewCell {
    @IBAction func lougoutBtnPressed(_ sender: Any) {
        // Pressed the logout button
    }
}
