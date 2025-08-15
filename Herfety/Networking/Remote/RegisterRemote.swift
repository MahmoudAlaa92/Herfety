//
//  AuthRemote.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 09/05/2025.
//

import Foundation

protocol RegisterRemoteProtocol {
    /// Async/await versions
    func registerUser(user: RegisterUser) async throws -> Registration
    /// Legacy callback versions for backward compatibility
    func registerUser(user: RegisterUser, completion: @escaping (Result<Registration, Error>) -> Void)
}

class RegisterRemote: Remote, RegisterRemoteProtocol, @unchecked Sendable {
    func registerUser(user: RegisterUser, completion: @escaping (Result<Registration, Error>) -> Void) {
        let parameters: [String: Sendable] = [
            "FName": user.FName,
            "LName": user.LName,
            "UserName": user.UserName,
            "Password": user.Password,
            "ConfirmPassword": user.ConfirmPassword,
            "Email": user.Email,
            "Phone": user.Phone,
            "image": user.image
        ]
        
        let request = MultipartFormDataRequest(
            method: .post,
            path: "api/RegisterUser/Register",
            parameters: parameters,
        )
        
        enqueue(request, completion: completion)
    }
}
// MARK: - Modern Concurrency
//
extension RegisterRemote {
    func registerUser(user: RegisterUser) async throws -> Registration {
        let parameters: [String: Sendable] = [
            "FName": user.FName,
            "LName": user.LName,
            "UserName": user.UserName,
            "Password": user.Password,
            "ConfirmPassword": user.ConfirmPassword,
            "Email": user.Email,
            "Phone": user.Phone,
            "image": user.image
        ]
        
        let request = MultipartFormDataRequest(
            method: .post,
            path: "api/RegisterUser/Register",
            parameters: parameters,
        )
        
        return try await enqueue(request)
    }
}
