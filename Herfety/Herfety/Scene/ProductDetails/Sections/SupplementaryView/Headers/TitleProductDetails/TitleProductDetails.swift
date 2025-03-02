//
//  TitleProductDetailss.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 28/02/2025.
//

import UIKit

class TitleProductDetails: UICollectionReusableView {
    
    static let identifier: String = "TitleProductDetails"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var avaliableLabel: UILabel!
    @IBOutlet weak var whishlistBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
}
// MARK: - Configuration
//
extension TitleProductDetails {
    
    func configure(titleLabl: String, priceLabel: String, avaliableLabel: String) {
        self.titleLabel.text = titleLabl
        self.priceLabel.text = priceLabel
        self.avaliableLabel.text = avaliableLabel
    }
    
    private func configureUI() {
        titleLabel.font = .title3
        priceLabel.font = .body
        avaliableLabel.font = .body
    }
}
// MARK: - Actions
//
extension TitleProductDetails {
    @IBAction func addToWhishlist(_ sender: Any) {
        
    }
}
