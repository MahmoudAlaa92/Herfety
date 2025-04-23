//
//  Ext + Images.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 03/04/2025.
//

import UIKit
import Kingfisher

protocol ImageProtocol {
    func setImage(with urlString: String, placeholderImage: UIImage)
}

extension UIImageView: ImageProtocol {
    func setImage(with urlString: String, placeholderImage: UIImage) {
        let url = URL(string: urlString)
        kf.setImage(with: url,
                    placeholder: placeholderImage,
                    options: [.transition(.fade(0.5))])
    }
}

extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        self.draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage ?? self
    }
}
