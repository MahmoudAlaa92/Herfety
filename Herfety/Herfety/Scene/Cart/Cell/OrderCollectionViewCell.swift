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
    ///
    var onChangeCountOrder: ((Int) -> Void)?
    
    // MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var nameProduct: UILabel!
    @IBOutlet weak var descriptionProduct: UILabel!
    @IBOutlet weak var priceProduct: UILabel!
    @IBOutlet weak var numberOfProduct: UILabel!
    @IBOutlet weak var minusAndPlusView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
        configureUi()
        Task {
            await loadInitialCount()
        }
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
        containerView.layer.shadowColor = Colors.primaryBlue.cgColor
        containerView.layer.cornerRadius = 20
        containerView.layer.shadowOpacity = 0.15
        containerView.layer.shadowRadius = 2
        containerView.layer.shadowOffset = .zero
    }
    
    private func updateCountLabel(_ count: Int) {
        numberOfProduct.text = "\(count)"
        onChangeCountOrder?(count)
    }
    
    private func loadInitialCount() async {
        let count = await DataStore.shared.getCountProductDetails()
        await MainActor.run {
            updateCountLabel(count)
        }
    }
}
// MARK: - Actions
//
extension OrderCollectionViewCell {
    @IBAction func minusButtonTapped(_ sender: UIButton) {
        Task {
            let newCount = await DataStore.shared.decrementProductCount()
            await MainActor.run {
                updateCountLabel(newCount)
            }
        }
    }
    
    @IBAction func plusButtonTapped(_ sender: UIButton) {
        Task {
            let newCount = await DataStore.shared.incrementProductCount()
            await MainActor.run {
                updateCountLabel(newCount)
            }
        }
    }
}
