import UIKit
import MHLoadingButton

class HerfetyButton: LoadingButton {
    
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
    convenience init() {
        self.init(frame: .zero)
    }
    // MARK: - SetUp
    func setUp() {
        let height: CGFloat = 52
        setTitleColor(.white, for: .normal)
        setTitle(self.title, for: .normal)
        layer.cornerRadius = 20
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor = Colors.primaryBlue.cgColor
        heightAnchor.constraint(equalToConstant: height).isActive = true
        titleLabel?.font = .systemFont(ofSize: 16.0, weight: .bold)
        indicator = BallSpinFadeIndicator(color: .white)
        
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
     func updateButtonConfiguration() {
        if #available(iOS 15.0, *) {
            var config = self.configuration ?? UIButton.Configuration.filled()
            config.title = self.title
            config.image = self.image
            /// font
            let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.title3]
            config.attributedTitle = AttributedString(self.title ?? "", attributes: AttributeContainer(attributes))
            self.configuration = config
        }
    }
}
