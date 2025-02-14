//
//  HeaderView.swift
//  Zagel
//
//  Created by Mahmoud Alaa on 28/10/2024.
//

import UIKit

class HeaderView: UICollectionReusableView {
    
    // MARK: - Properties
    //
    static let headerIdentifier = "HeaderView"
    
    // MARK: - Outlets
    //
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var seeAll: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUp()
    }
    
}

// MARK: - Configure
//
extension HeaderView {
    
    func configure(title: String, description: String,titleFont: UIFont? = nil,titleColor: UIColor? = nil, shouldShowButton: Bool) {
        titleLabel.text = title
        titleLabel.font = titleFont
        titleLabel.textColor = titleColor
        descriptionLabel.text = description
        seeAll.isHidden = !shouldShowButton
        seeAll.applyStyle(.labelButton, title: "seeAll")
    }
    
    private func setUp() {
        titleLabel.font = .callout
        
        descriptionLabel.font = .callout
        descriptionLabel.textColor = Colors.primaryBlue
    }
    
}
// MARK: - Actions
//
extension HeaderView {
    
    @IBAction func seeAllPressed(_ sender: UIButton) {
        // seeAllButton
    }
}
