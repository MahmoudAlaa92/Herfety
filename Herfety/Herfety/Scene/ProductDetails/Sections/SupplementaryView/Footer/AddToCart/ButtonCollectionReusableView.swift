//
//  ButtonCollectionReusableView.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 02/03/2025.
//

import UIKit

class ButtonCollectionReusableView: UICollectionReusableView {

    static let identifier = "ButtonCollectionReusableView"
    // MARK: - Outlets
    @IBOutlet weak var button: PrimaryButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func configure(with viewModel: ViewModel) {
        button.setTitle(viewModel.title, for: .normal)
        button.addTarget(viewModel.target, action: viewModel.action, for: .touchUpInside)
    }
}
// MARK: - ViewModel
//
extension ButtonCollectionReusableView {
    /// The ViewModel structure for HerfetyCollectionReusableView.
    struct ViewModel {
        let title: String
        let target: Any?
        let action: Selector
    }
}
