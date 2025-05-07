//
//  LoginViewModelType.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 07/05/2025.
//

import Foundation

/// Login Input & Output
///
typealias LoginViewModelType = LoginViewModelInput & LoginViewModelOutput

/// Login ViewModel Input
///
protocol LoginViewModelInput {
    func updateEmail(_ text: String)
    func updatePassword(_ text: String)
    func loginTapped()
}

/// Login ViewModel Output
///
protocol LoginViewModelOutput {
    func configureOnButtonEnabled(onEnabled: @escaping (Bool) -> Void)
    var onLoginTapped: (() -> Void)? { get set}
}
