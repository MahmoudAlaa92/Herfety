//
//  ImagesProductDetailsCollectionViewCell.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 28/02/2025.
//

import UIKit

class ImagesProductDetailsCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ImagesProductDetailsCollectionViewCell"

    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var indexProduct: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

}

// MARK: - Configuration
//
extension ImagesProductDetailsCollectionViewCell {
    
    private func configureUI() {
        imageProduct.contentMode = .scaleAspectFit
        
        indexProduct.font = .callout
    }
}
