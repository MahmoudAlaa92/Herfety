//
//  FacebookButton.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 20/04/2025.
//
import UIKit

class FacebookButton: HerfetyButton {
    override func setUp() {
        super.setUp()
        title = "Continue with Facebook"
        image = Images.iconFacebook
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
