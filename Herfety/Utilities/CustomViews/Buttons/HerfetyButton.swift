import UIKit

class HerfetyButton: UIButton {
    
    // MARK: - Properties
    var title: String? {
        didSet {
            updateButtonConfiguration()
        }
    }
    
    var image: UIImage? {
        didSet {
            updateButtonConfiguration()
        }
    }
    // MARK: - Init
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
            var config = UIButton.Configuration.filled()
            config.titlePadding = 8  /// Adjust spacing between text & image
            config.imagePadding = 10 /// Adjust spacing between button image and text
            config.cornerStyle = .medium
            config.imagePlacement = .leading /// Ensure the image is on the left
            config.baseBackgroundColor = Colors.primaryBlue
            
            self.configuration = config
            updateButtonConfiguration()
        }
    }
}
// MARK: - Configuration
//
extension HerfetyButton {
    
    /// Update button configuration
    private func updateButtonConfiguration() {
        if #available(iOS 15.0, *) {
            var config = self.configuration ?? UIButton.Configuration.filled()
            config.title = title
            config.image = image
            let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.title3]
            config.attributedTitle = AttributedString(title ?? "", attributes: AttributeContainer(attributes))
            self.configuration = config
        }
    }
}
