//
//  SliderImagesCollectionViewCell.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 04/02/2025.
//

import UIKit

class SliderImagesCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let cellIdentifier = "SliderImagesCollectionViewCell"

    // MARK: - Outlets
    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var rightImage: UIImageView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var middleLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    @IBOutlet weak var leftButton: UIButton!
    
    @IBOutlet weak var rightButton: UIButton!
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setUP()
    }
    
    // MARK: - Configure
    private func setUP() {
        backGroundView.backgroundColor = Colors.secondaryBLue
        backGroundView.layer.cornerRadius = 10
        backGroundView.clipsToBounds = true
        backGroundView.layer.masksToBounds = true
        
        leftButton.backgroundColor = Colors.secondaryGray
        rightButton.backgroundColor = Colors.secondaryGray
        
        leftButton.layer.cornerRadius = leftButton.frame.size.width / 2
        rightButton.layer.cornerRadius = rightButton.frame.size.width / 2
        leftButton.clipsToBounds = true
        rightButton.clipsToBounds = true
        
        topLabel.font = .callout
        middleLabel.font = .calloutBold
        bottomLabel.font = .body
        
        topLabel.textColor = Colors.secondaryGray
        middleLabel.textColor = Colors.secondaryGray
        bottomLabel.textColor = Colors.secondaryGray
        
        topLabel.numberOfLines = 2
        middleLabel.numberOfLines = 2
        bottomLabel.numberOfLines = 2
        
        topLabel.lineBreakMode = .byWordWrapping
        middleLabel.lineBreakMode = .byWordWrapping
        bottomLabel.lineBreakMode = .byWordWrapping
    }

}
