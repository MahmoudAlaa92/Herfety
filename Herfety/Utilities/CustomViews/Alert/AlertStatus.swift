//
//  AlertStatus.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 17/02/2025.
//

import UIKit

enum AlertStatus {
    case success
    case warning
    case error
    
    var title: String {
        switch self {
        case .success:
            return "Success"
        case .warning:
            return "Warning"
        case .error:
            return "Error"
        }
    }
    
    var image: UIImage {
        switch self {
        case .success:
            return Images.alertAddToCart
        case .warning:
            return Images.alertWarning
        case .error:
            return Images.alertError
        }
    }
}
