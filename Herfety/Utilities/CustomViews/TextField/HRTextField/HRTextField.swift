

import UIKit

protocol HRTextFieldDelegate: AnyObject {
}
class HRTextField: UIView {
    // MARK: - IBOutlet
    @IBOutlet weak var containerView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var bottomLine: UIView!
    
    // MARK: - Properities
    var title: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }
    var placeholder: String? {
        get { textfield.placeholder }
        set { textfield.placeholder = newValue }
    }
    weak var delegate: HRTextFieldDelegate?
    // MARK: - Init
    //
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
        configureUI()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNib()
        configureUI()
    }
    /// Loads the view from a nib file and adds it as a subview to the OnboardingTextField view.
    private func loadNib() {
        if let loadedViews = Bundle.main.loadNibNamed(String(describing: Self.self), owner: self, options: nil),
            let view = loadedViews.first as? UIView {
            addSubview(view)
            view.frame = bounds
        }
    }
}
// MARK: - Configurations
//
private extension HRTextField {
    func configureUI() {
        backgroundColor = Colors.hPrimaryBackground
        containerView.backgroundColor = Colors.hBackgroundColor
        configureTitleLable()
        configureTextField()
        configureBottomLine()
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        func configureTitleLable() {
            titleLabel.textColor = Colors.primaryBlue
            titleLabel.font = .title3
        }
        
        func configureTextField() {
            textfield.borderStyle = .none
            textfield.textColor = Colors.hCardTextFieldPlaceholder
            textfield.backgroundColor = Colors.hPrimaryBackground
        }
        
        func configureBottomLine() {
            bottomLine.backgroundColor = Colors.hTextFieldUnderLine
        }
    }
}
