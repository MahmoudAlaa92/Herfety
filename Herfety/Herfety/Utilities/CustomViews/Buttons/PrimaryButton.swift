//
//  PrimaryButton.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 13/02/2025.
//

import UIKit

class PrimaryButton: HerfetyButton {
  
    override func setUp() {
        super.setUp()
        setTitleColor(Colors.hMainTheme, for: .normal)
        backgroundColor = Colors.primaryBlue
    }
}

