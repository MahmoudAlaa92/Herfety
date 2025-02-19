//
//  InfoShippingCollectionViewCell.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 13/02/2025.
//

import UIKit

class InfoShippingCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties
    static let identifier: String = "InfoShippingCollectionViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameOfPerson: UILabel!
    @IBOutlet weak var addressOfPerson: UILabel!
    @IBOutlet weak var phoneOfPerson: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureContainerView()
        configureUi()
    }

}

// MARK: - Configuration
//
extension InfoShippingCollectionViewCell {
    
    /// Configures the appearance of the container view, including shadows and corner radius.
    private func configureContainerView() {
        containerView.backgroundColor = Colors.hMainTheme
        containerView.layer.shadowColor = Colors.hPrimaryButton.cgColor
        containerView.layer.cornerRadius = 15
        containerView.layer.shadowOpacity = 0.2
        containerView.layer.shadowRadius = 5
        containerView.layer.shadowOffset = .zero
    }
    /// Configure UI
    private func configureUi() {
        imageView.contentMode = .scaleAspectFill
        
        nameOfPerson.font = .callout
        
        addressOfPerson.font = .caption1
        addressOfPerson.textColor = Colors.labelGray
        
        phoneOfPerson.font = .footnote
    }
}
