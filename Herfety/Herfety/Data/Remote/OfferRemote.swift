//
//  ProductRemote.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 21/04/2025.
//

import Foundation

protocol OfferRemoteProtocol {
    /// Async/await versions
    func loadAllOffer() async throws -> [Products]
    func loadSpecificOffer(disount: Int) async throws -> [Products]
    /// Legacy callback versions for backward compatibility
    func loadAllOffer(completion: @escaping (Result<[Products], Error>) -> Void)
    func loadSpecificOffer(disount: Int ,completion: @escaping (Result<[Products], Error>) -> Void)
}

class OfferRemote: Remote, OfferRemoteProtocol, @unchecked Sendable {
     func loadAllOffer(completion: @escaping (Result<[Products], Error>) -> Void) {
         
        let request = HerfetyRequest(
            method: .get,
            path: "api/Home/GetOffer")
         
        enqueue(request, completion: completion)
    }
    func loadSpecificOffer(disount: Int, completion: @escaping (Result<[Products], any Error>) -> Void) {
        
        let parameters = ["offer": disount]
        
        let request = HerfetyRequest(
            method: .get,
            path: "api/Home/GetOffer" ,
            parameters: parameters)
        
        enqueue(request, completion: completion)
    }
}
// MARK: - Modern Concurrency
//
extension OfferRemote {
    func loadAllOffer() async throws -> [Products] {
        let request = HerfetyRequest(
            method: .get,
            path: "api/Home/GetOffer")
         
        return try await enqueue(request)
    }
    
    func loadSpecificOffer(disount: Int) async throws -> [Products] {
        let parameters = ["offer": disount]
        
        let request = HerfetyRequest(
            method: .get,
            path: "api/Home/GetOffer" ,
            parameters: parameters)
        
        return try await enqueue(request)
    }
}
