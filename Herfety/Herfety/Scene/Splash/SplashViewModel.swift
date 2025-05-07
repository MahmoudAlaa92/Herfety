//
//  SplashViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 07/05/2025.
//

import Foundation

class SplashViewModel {
    
    // MARK: - Properties
    var onLoginTapped: (() -> Void)?
    var onSignUpTapped: (() -> Void)?
    
    
    func loginTapped() {
        onLoginTapped?()
    }
    
    func signUpTapped() {
        onSignUpTapped?()
    }
}
