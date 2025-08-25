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
    
    // MARK: - Outlets
    @IBOutlet weak var descriptionTitle: UILabel!
    @IBOutlet weak var numberProduct: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var minusAndPlusStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
        Task {
            await loadInitialCount()
        }
    }
}
// MARK: - Configuration
//
extension DescriptionProductDetails {
    private func configureUI() {
        minusAndPlusStackView.backgroundColor = Colors.buttonGray
        minusAndPlusStackView.layer.cornerRadius = 20
        
        descriptionTitle.text = L10n.Product.Details.description
        descriptionLabel.numberOfLines = 0
        descriptionTitle.font = .calloutBold
        
        descriptionLabel.font = .body
        descriptionLabel.textColor = Colors.hSocialButton
    }
    
    func configure(descriptionLabel: String){
        self.descriptionLabel.text = descriptionLabel
    }
    
    private func loadInitialCount() async {
        let count = await DataStore.shared.getCountProductDetails()
        await MainActor.run {
            updateCountLabel(count)
        }
    }
    
    private func updateCountLabel(_ count: Int) {
        numberProduct.text = "\(count)"
    }
    
}
// MARK: - Actions
//
extension DescriptionProductDetails {
    @IBAction func minusPressed(_ sender: Any) {
        Task {
            let newCount = await DataStore.shared.decrementProductCount()
            await MainActor.run {
                updateCountLabel(newCount)
            }
        }
    }
    @IBAction func plusPressed(_ sender: Any) {
        Task {
            let newCount = await DataStore.shared.incrementProductCount()
            await MainActor.run {
                updateCountLabel(newCount)
            }
        }
    }
}
