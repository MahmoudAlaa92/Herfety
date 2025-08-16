//
//  GenderButton.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 03/04/2025.
//

import UIKit

protocol GenderButtonDelegate: AnyObject {
    func didTapGenderButton(_ button: GenderButton)
}

class GenderButton: UIButton {
    
    weak var delegate: GenderButtonDelegate?
    
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
    private func setUp() {
        configureAppearance()
        addTarget(self, action: #selector(toggleSelection), for: .touchUpInside)
    }
    
    @objc private func toggleSelection() {
        delegate?.didTapGenderButton(self)
    }
    
    func updateSelection(isSelected: Bool) {
        self.isSelected = isSelected
        configureAppearance()
    }
}

// MARK: - Configuration
//
extension GenderButton {
    private func configureAppearance() {
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .medium
        config.baseForegroundColor = isSelected ? .white : .gray
        config.baseBackgroundColor = isSelected ? .primaryBlue : .white
        /// Resize the image to make it smaller
          if let image = UIImage(systemName: isSelected ? "circle.inset.filled" : "circle") {
              let scaledImage = image.withRenderingMode(.alwaysOriginal).resized(to: CGSize(width: 16, height: 16))
              config.image = scaledImage.withRenderingMode(.alwaysTemplate)
          }
        config.imagePadding = 8
        config.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 6, bottom: 12, trailing: 6)
        
        config.titleTextAttributesTransformer =  UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            
            return outgoing
        }
        
        self.configuration = config
        self.layer.borderWidth = isSelected ? 0 : 0.5
        self.layer.borderColor = Colors.hCardTextFieldPlaceholder.cgColor
    }
}
