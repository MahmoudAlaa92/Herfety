//
//  HerfetyButton.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 13/02/2025.
//

import UIKit

class HerfetyButton: UIButton {
    
    var title: String? {
        get { titleLabel?.text }
        set { setTitle(newValue, for: .normal) }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    func setUp() {
        let height: CGFloat = 52
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = 10
        heightAnchor.constraint(equalToConstant: height).isActive = true
        titleLabel?.font = .systemFont(ofSize: 16.0, weight: .bold)
        
        if #available(iOS 15.0, *) {
            #warning("Edit this button configuration")
            var config = UIButton.Configuration.filled()
            config.titlePadding = 8  /// Adjust spacing between text & image
            config.imagePadding = 10  /// Adjust spacing between button image and text
            config.cornerStyle = .medium
            self.configuration = config
        }
    }
}
