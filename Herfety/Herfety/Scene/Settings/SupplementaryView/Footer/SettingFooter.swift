//
//  SettingFooter.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 07/03/2025.
//

import UIKit

class SettingFooter: UICollectionReusableView {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var femaleBtn: UIButton!
    @IBOutlet weak var maleBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
}
// MARK: - Configuration
//
extension SettingFooter {
    private func configureUI() {
        
    }
}
// MARK: - Actions
//
extension SettingFooter {
    @IBAction func malePressed(_ sender: Any) {
    }
    
    @IBAction func femalePressed(_ sender: Any) {
    }
}
