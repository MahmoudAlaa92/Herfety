//
//  Logout.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 12/04/2025.
//

import UIKit

class SecondaryButton: UICollectionReusableView {
    
    static let identifier = "HerfetyFooterReusableView"
    
    let button: HerfetyButton = {
        let btn = HerfetyButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        addSubview(button)

        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            button.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
}
