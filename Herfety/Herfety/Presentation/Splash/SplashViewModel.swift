//
//  SplashViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 07/05/2025.
//

import Combine

final class SplashViewModel: SplashViewModelType {
    
    // MARK: - Output
    let onLogin = PassthroughSubject<Void, Never>()
    let onSignUp = PassthroughSubject<Void, Never>()
    
    // MARK: - Input
    func loginTapped() {
        onLogin.send()
    }
    
    func signUpTapped() {
        onSignUp.send()
    }
}
