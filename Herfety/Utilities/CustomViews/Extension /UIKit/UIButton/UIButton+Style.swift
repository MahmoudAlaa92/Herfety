//
//  File.swift
//  UIHerfety
//
//  Created by Mahmoud Alaa on 07/02/2025.
//

import UIKit

public extension UIButton {
    
    enum buttonStyle {
        case primaryButton
        case secondaryButton
        case labelButton
        case wichlistButton
    }
    
    func applyStyle(_ style: buttonStyle ,title: String) {
        
        switch style {
        case .primaryButton:
            configureButton(buttonColor: Colors.primaryBlue,
                            title: title,
                            titleColor: .white,
                            font: .caption1,
                            cornerRaduis: 15)
        case .secondaryButton:
            break
        case .labelButton:
            configureButton(buttonColor: .clear,
                            title: title,
                            titleColor: .black,
                            font: .caption1,
                            image: Images.chevronForward
            )
        case .wichlistButton:
            break
        }
    }
}
// MARK: - Configuraiton
//
extension UIButton {
    private func configureButton(buttonColor: UIColor,
                                 title: String,
                                 titleColor: UIColor,
                                 font: UIFont,
                                 cornerRaduis: CGFloat = 10,
                                 image: UIImage? = nil) {
        
        self.layer.cornerRadius = cornerRaduis
        self.layer.masksToBounds = true
        
        
        if #available(iOS 15.0, *) {
            var config = UIButton.Configuration.filled()
            config.baseBackgroundColor = buttonColor
            config.baseForegroundColor = titleColor
            config.title = title
            let attributes: [NSAttributedString.Key: Any] = [.font: font]
            config.attributedTitle = AttributedString(title, attributes: AttributeContainer(attributes))
            config.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                           leading: 10,
                                                           bottom: 0,
                                                           trailing: 10)
            if image != nil {
                config.image = Images.chevronForward
                config.imagePadding = 5
                config.imagePlacement = .trailing }
            
            self.configuration = config
            
        } else {
            // earlier versions
        }
        
        if constraints.isEmpty {
            self.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
    }
}
