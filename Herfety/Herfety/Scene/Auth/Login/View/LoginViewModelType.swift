//
//  LoginViewModelType.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 07/05/2025.
//

import UIKit
import Combine
import AuthenticationServices

/// Combines both input & output responsibilities
typealias LoginViewModelType = LoginViewModelInput & LoginViewModelOutput

// MARK: - ViewModel Input
//
protocol LoginViewModelInput {
    /// Called when the email field updates
    func updateEmail(_ text: String)
    
    /// Called when the password field updates
    func updatePassword(_ text: String)
    
    /// Called when login button is tapped
    func loginTapped()
    
    /// Initiates login via Facebook
    func loginWithFacebook(from viewController: UIViewController)
    
    /// Initiates login via Google
    func loginWithGoogle(from viewController: UIViewController)
    
    /// Initiates login via Apple
    func loginWithApple(credential: ASAuthorizationAppleIDCredential)
}

// MARK: - ViewModel Output
//
protocol LoginViewModelOutput {
    /// Enables or disables the login button based on input validity
    func configureOnButtonEnabled(onEnabled: @escaping (Bool) -> Void)
    
    /// Emits login success events
    var loginSuccess: PassthroughSubject<Void, Never> { get }
    
    /// Emits login error messages
    var loginError: PassthroughSubject<String, Never> { get }
}
