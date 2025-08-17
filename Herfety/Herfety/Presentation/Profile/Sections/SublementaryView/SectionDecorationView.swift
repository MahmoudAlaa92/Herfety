//
//  SectionDecorationView.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 06/03/2025.
//

import UIKit

class SectionDecorationView: UICollectionReusableView {
    // MARK: - Properties
    static let identifier = "SectionDecorationView"
    let view = UIView()
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - Configuration
//
extension SectionDecorationView {
    private func configureUI() {
        addSubview(view)
        view.layer.borderWidth = 0.5
        view.layer.borderColor = Colors.buttonGray.cgColor
        view.layer.cornerRadius = 13
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        if let superview = view.superview {
            NSLayoutConstraint.activate([
                view.topAnchor.constraint(equalTo: superview.topAnchor, constant: 0),
                view.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 5),
                view.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -40),
                view.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -5)
            ])}
        
        /// shadow
        view.backgroundColor = Colors.hMainTheme
        view.layer.shadowColor = Colors.primaryBlue.cgColor
        view.layer.shadowOpacity = 0.05
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 13
    }
}
