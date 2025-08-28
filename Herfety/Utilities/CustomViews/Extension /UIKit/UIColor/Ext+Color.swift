//
//  Ext+Color.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 28/08/2025.
//

import UIKit

extension UIColor {
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }

        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }

    var toHex: String? {
        guard let components = cgColor.components else { return nil }
        let r, g, b: Float

        if components.count == 2 {
            r = Float(components[0])
            g = Float(components[0])
            b = Float(components[0])
        } else if components.count >= 3 {
            r = Float(components[0])
            g = Float(components[1])
            b = Float(components[2])
        } else {
            return nil
        }

        return String(format: "#%02lX%02lX%02lX",
                      lroundf(r * 255),
                      lroundf(g * 255),
                      lroundf(b * 255))
    }

}
