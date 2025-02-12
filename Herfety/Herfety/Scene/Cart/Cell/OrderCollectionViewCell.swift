//
//  OrderCollectionViewCell.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 11/02/2025.
//

import UIKit
import UIHerfety

class OrderCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let identifier = "OrderCollectionViewCell"
    
    // MARK: - Outlets
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
    }
}
// MARK: - Actions
//
extension OrderCollectionViewCell {
    
    private func configure() {
        minusAndPlusView.backgroundColor = Colors.buttonGray
        minusAndPlusView.layer.cornerRadius = 20
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
