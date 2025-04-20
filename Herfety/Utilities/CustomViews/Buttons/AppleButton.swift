//
//  AppleButton.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 20/04/2025.
//
import UIKit

class AppleButton: HerfetyButton {
    override func setUp() {
        super.setUp()
        image = Images.iconApple
        setFacebookStyle()
    }

    private func setFacebookStyle() {
        if #available(iOS 15.0, *) {
            var config = self.configuration ?? UIButton.Configuration.filled()
            config.baseBackgroundColor = Colors.hPrimaryBackground
            config.baseForegroundColor = Colors.primaryBlue
            self.configuration = config
        }
        tintColor = Colors.hMainTheme
    }
}
