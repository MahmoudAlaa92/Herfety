//
//  SearchTextField.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 02/05/2025.
//
import UIKit

class SearchTextField: UITextField {
    // MARK: Init
    //
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
}
// MARK: - Congigure View
//
extension SearchTextField {
    private func configureView() {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        layer.cornerRadius = 12
        clipsToBounds = true
        borderStyle = .none
        backgroundColor = Colors.hSecondaryBackground
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: frame.height))
        leftViewMode = .always
        placeholder = "Search ..."
            addPaddingRightIcon(Images.search, padding: 16, tintColor: .gray)
    }
    
    func addPaddingRightIcon(_ image: UIImage?, padding: CGFloat, tintColor: UIColor = .blue) {
        guard let image = image else { return }

        let imageView = UIImageView(image: image)
        imageView.tintColor = tintColor
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false

        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding / 2),
            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding / 2),
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            imageView.widthAnchor.constraint(equalToConstant: image.size.width),
            imageView.heightAnchor.constraint(equalToConstant: image.size.height)
        ])

        self.rightView = containerView
        self.rightViewMode = .always
    }

}
