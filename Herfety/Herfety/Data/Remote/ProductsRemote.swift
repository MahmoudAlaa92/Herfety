//
//  ProductsRemote.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 23/04/2025.
//

import Foundation

protocol ProductsRemoteProtocol {
    /// Async/await versions
    func loadAllProducts() async throws -> [Products]
    /// Legacy callback versions for backward compatibility
    func loadAllProducts(completion: @escaping (Result<[Products], Error>) -> Void)
}

class ProductsRemote: Remote, ProductsRemoteProtocol, @unchecked Sendable {
    
    func loadAllProducts(completion: @escaping (Result<[Products], Error>) -> Void) {
        let request = HerfetyRequest(
            method: .get,
            path: "api/Home/Offers")
        
        enqueue(request, completion: completion)
    }
}
// MARK: - Modern Async/Await Methods
//
extension ProductsRemote {
    func loadAllProducts() async throws -> [Products] {
        let request = HerfetyRequest(
            method: .get,
            path: "api/Home/Offers")
        
        return try await enqueue(request)
    }
}
