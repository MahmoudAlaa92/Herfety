//
//  OrderCollectionViewCell.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 11/02/2025.
//

import UIKit

class OrderCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let identifier = "OrderCollectionViewCell"
    
    // MARK: - Outlets
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageProduct: UIImageView!
    
    @IBOutlet weak var nameProduct: UILabel!
    @IBOutlet weak var descriptionProduct:
    UILabel!
    @IBOutlet weak var priceProduct: UILabel!
    @IBOutlet weak var numberOfProduct: UILabel!
    
    @IBOutlet weak var minusAndPlusView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configure()
        configureUi()
    }
}
// MARK: - Configuration
//
extension OrderCollectionViewCell {
    
    private func configure() {
        minusAndPlusView.backgroundColor = Colors.buttonGray
        minusAndPlusView.layer.cornerRadius = 20
        
        nameProduct.font = .title3
        
        descriptionProduct.font = .caption1
        descriptionProduct.textColor = Colors.labelGray
        
        priceProduct.font = .callout
    }
    
    private func configureUi() {
        containerView.backgroundColor = Colors.hMainTheme
        containerView.layer.shadowColor = Colors.hPrimaryButton.cgColor
        containerView.layer.cornerRadius = 20
        containerView.layer.shadowOpacity = 0.2
        containerView.layer.shadowRadius = 5
        containerView.layer.shadowOffset = .zero
    }
}
// MARK: - Actions
//
extension OrderCollectionViewCell {
    @IBAction func minusButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func plusButtonTapped(_ sender: UIButton) {
    }
}
