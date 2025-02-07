//
//  HeaderView.swift
//  Zagel
//
//  Created by Mahmoud Alaa on 28/10/2024.
//

import UIKit
import UIHerfety

class HeaderView: UICollectionReusableView {

    static let headerIdentifier = "HeaderView"
        
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var seeAll: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUp()
    }
    
    private func setUp() {
        
        titleLabel.font = .footnote
        descriptionLabel.font = .callout
        descriptionLabel.textColor = Colors.primaryBlue
        
        seeAll.applyStyle(.labelButton, title: "seeAll")
        
    }
    
    @IBAction func seeAllPressed(_ sender: UIButton) {
        print("Hello world")
    }
    
}
