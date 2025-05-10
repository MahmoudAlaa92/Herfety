////
////  AuthRemote.swift
////  Herfety
////
////  Created by Mahmoud Alaa on 09/05/2025.
////
//
//import Foundation
//
//protocol RegisterRemoteProtocol {
//    func registerUser(user: RegisterUser, completion: @escaping (Result<Registration, Error>) -> Void)
//}
//
//class RegisterRemote: Remote, RegisterRemoteProtocol {
//    
//    func registerUser(user: RegisterUser, completion: @escaping (Result<Registration, Error>) -> Void) {
//        
//        let parameters: [String : Sendable] = [
//            "FName": "Mahmoud",
//            "LName": "Alaa",
//            "UserName": "MA",
//            "Password": "123455555",
//            "ConfirmPassword": "123455555",
//            "Email": "Ma@gmail.com",
//            "Phone": "01142128919",
//        ]
//        print(parameters)
//        
//        let request = HerfetyRequest(method: .post, path: "api/RegisterUser/Register", parameters: parameters)
//        
//        enqueue(request, completion: completion)
//    }
//}
