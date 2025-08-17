//
//  CategoriesCollectionViewCell.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 04/02/2025.
//

import UIKit


class CategoriesCollectionViewCell: UICollectionViewCell {

    static let cellIdentifier = "CategoriesCollectionViewCell"
    // MARK: - Outlets
    @IBOutlet weak var backGround: UIView!
    @IBOutlet weak var imageOfCategory: UIImageView!
    @IBOutlet weak var nameOfCategory: UILabel!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configure() 
    }
    
    // MARK: - Configure
    private func configure() {
    
        backGround.layer.cornerRadius = backGround.layer.frame.size.width / 6
        backGround.clipsToBounds = true
        
        backGround.backgroundColor = Colors.heavyGray
        imageOfCategory.contentMode = .scaleAspectFill
        
        nameOfCategory.font = .caption2
        nameOfCategory.textColor = Colors.labelGray
        nameOfCategory.numberOfLines = 1
    }
}
