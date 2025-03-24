import UIKit

// MARK: - Buttons
//
public extension UIFont {
        
    static var Button: UIFont {
        return UIFont(name: "DMSans-Medium", size: 14) ?? .systemFont(ofSize: 14)
    }
    
    static var smallButton: UIFont {
        return UIFont(name: "DMSans-Medium", size: 12) ?? .systemFont(ofSize: 12)
    }
}

// MARK: - Labels
//
public extension UIFont {
    static var title1: UIFont {
        return UIFont(name:"DMSans-Bold" ,size: 26) ?? .systemFont(ofSize: 26)
    }
    
    static var title2: UIFont {
        return UIFont(name: "DMSans-Bold", size: 20) ?? .systemFont(ofSize: 20)
    }

    static var title3: UIFont {
        return UIFont(name: "DMSans-Medium", size: 18) ?? .systemFont(ofSize: 18)
    }

    static var callout: UIFont {
        return UIFont(name: "DMSans-Medium", size: 14) ?? .systemFont(ofSize: 14)
    }

    
    static var calloutBold: UIFont {
        return UIFont(name: "DMSans-Bold", size: 14) ?? .systemFont(ofSize: 14)
    }
    
    static var footnote: UIFont {
        return UIFont(name: "DMSans-Bold", size: 12) ?? .systemFont(ofSize: 12)
    }

    static var body: UIFont {
        return UIFont(name: "DMSans-Regular", size: 14) ?? .systemFont(ofSize: 14)
    }
    
    static var body2: UIFont {
        return UIFont(name: "DMSans-Regular", size: 12) ?? .systemFont(ofSize: 12)
    }

    static var caption1: UIFont {
        return UIFont(name: "DMSans-Regular", size: 10) ?? .systemFont(ofSize: 10)
    }
    
    static var caption2: UIFont {
        return UIFont(name: "DMSans-Regular", size: 8) ?? .systemFont(ofSize: 8)
    }
}

// MARK: - TextField
//
public extension UIFont {
    
    static var textField: UIFont {
        return UIFont(name: "DMSans-Medium", size: 14) ?? .systemFont(ofSize: 14)
    }
}
