//
//  DescriptionProductDetails.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 28/02/2025.
//
import UIKit

class DescriptionProductDetails: UICollectionReusableView {
    // MARK: - Properties
    static let identifier: String = "DescriptionProductDetails"
    ///
    var productCount: Int {
        get { return Int(numberProduct.text ?? "1") ?? 1 }
        set {
            numberProduct.text = "\(newValue)"
            CustomeTabBarViewModel.shared.countProductDetails = newValue
        }
    }
    // MARK: - Outlets
    @IBOutlet weak var descriptionTitle: UILabel!
    @IBOutlet weak var numberProduct: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var minusAndPlusStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
}
// MARK: - Configuration
//
extension DescriptionProductDetails {
    private func configureUI() {
        minusAndPlusStackView.backgroundColor = Colors.buttonGray
        minusAndPlusStackView.layer.cornerRadius = 20
        
        descriptionTitle.text = "Description"
        descriptionLabel.numberOfLines = 0
        descriptionTitle.font = .calloutBold
        
        descriptionLabel.font = .body
        descriptionLabel.textColor = Colors.hSocialButton
        
        productCount = 1
    }

    func configure(descriptionLabel: String){
        self.descriptionLabel.text = descriptionLabel
    }
}
// MARK: - Actions
//
extension DescriptionProductDetails {
    @IBAction func minusPressed(_ sender: Any) {
        if productCount > 1 {
            productCount -= 1
        }
    }
    @IBAction func plusPressed(_ sender: Any) {
        productCount += 1
    }
}
