//
//  LoginRemote.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 10/05/2025.
//

import Foundation

protocol LoginRemoteProtocol {
    func login(email: String, password: String, completion: @escaping (Result<Registration, Error>) -> Void)
}

class LoginRemote: Remote, LoginRemoteProtocol {
    func login(email: String, password: String, completion: @escaping (Result<Registration, Error>) -> Void) {
        
        let parameters: [String: Sendable] = [
            "UserName": email,
            "Password": password
        ]
        let request = HerfetyRequest(
            method: .post,
            path: "api/RegisterUser/LogIn",
            parameters: parameters
        )
        enqueue(request, completion: completion)
    }
}
