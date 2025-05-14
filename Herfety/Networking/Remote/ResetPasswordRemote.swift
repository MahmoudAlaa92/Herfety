//
//  ResetPasswordRemote.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 14/05/2025.
//

import Foundation

protocol ResetPasswordRemoteProtocol {
    func reset(parameter: ResetPassword ,completion: @escaping (Result<ResponseReset, Error>) -> Void)
}

class ResetPasswordRemote: Remote, ResetPasswordRemoteProtocol {
    func reset(parameter: ResetPassword ,completion: @escaping (Result<ResponseReset, Error>) -> Void){
        let parameter: [String: Any] = [
            "UserName" : parameter.UserName,
            "CurrentPassword" : parameter.CurrentPassword,
            "NewPassword" : parameter.NewPassword,
            "ConfirmPassword" : parameter.ConfirmPassword,
        ]
        let request = HerfetyRequest(
            method: .put,
            path: "api/Users/ChangeUserPassword",
            parameters: parameter
        )
        enqueue(request, completion: completion)
    }
}
