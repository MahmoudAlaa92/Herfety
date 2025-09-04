//
//  SecondaryButton.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 20/04/2025.
//
import UIKit

class SecondaryButtonn: HerfetyButton {
    override func setUp() {
        super.setUp()
        if #available(iOS 15.0, *) {
            var config = self.configuration ?? UIButton.Configuration.filled()
            config.baseBackgroundColor = .white
            config.baseForegroundColor = Colors.primaryBlue
            self.configuration = config
        }
        tintColor = Colors.hMainTheme
    }
}
