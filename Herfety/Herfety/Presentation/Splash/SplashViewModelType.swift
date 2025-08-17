//
//  SplashViewModelType.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 13/08/2025.
//

import Combine

/// Combines both input & output responsibilities
typealias SplashViewModelType = SplashViewModelInput & SplashViewModelOutput

// MARK: - ViewModel Input
protocol SplashViewModelInput {
    /// Called when login button is tapped
    func loginTapped()
    
    /// Called when sign up button is tapped
    func signUpTapped()
}

// MARK: - ViewModel Output
protocol SplashViewModelOutput {
    /// Emits when login should be navigated to
    var onLogin: PassthroughSubject<Void, Never> { get }
    
    /// Emits when sign up should be navigated to
    var onSignUp: PassthroughSubject<Void, Never> { get }
}
