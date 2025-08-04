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

extension UIImage {
    
    private static let imageCache = NSCache<NSString, UIImage>()
    
    static func load(from urlString: String) async -> UIImage? {
        // Check cache first
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            return cachedImage
        }
        
        guard let url = URL(string: urlString) else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else { return nil }
            
            // Cache the image
            imageCache.setObject(image, forKey: urlString as NSString)
            return image
        } catch {
            print("Image loading failed:", error)
            return nil
        }
    }
}
