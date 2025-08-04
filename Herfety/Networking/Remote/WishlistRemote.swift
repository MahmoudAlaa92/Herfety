//
//  WishlistRemote.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 29/04/2025.
//

import Foundation

protocol ProductsOfWishlistRemoteProtocol {
    
    /// Async/await versions
    func loadAllProducts(userId: Int) async throws -> [Wishlist]
    func removeProduct(userId: Int, productId: Int) async throws -> WishlistMessage
    /// Legacy callback versions for backward compatibility
    func loadAllProducts(userId: Int, completion: @escaping (Result<[Wishlist], Error>) -> Void)
    func addNewProduct(userId: Int, productId: Int, completion: @escaping (Result<Bool, Error>) -> Void)
    func removeProduct(userId: Int, productId: Int, completion: @escaping (Result<WishlistMessage, Error>) -> Void)
}
// MARK: - Modern Async/Await Methods
//
class ProductsOfWishlistRemote: Remote, ProductsOfWishlistRemoteProtocol, @unchecked Sendable {
    /// get
    func loadAllProducts(userId: Int) async throws -> [Wishlist] {
        let parameters = ["id": userId]
        let request = HerfetyRequest(
            method: .get,
            path: "api/WishLists",
            parameters: parameters)
        
        return try await enqueue(request)
    }
    /// delete
    func removeProduct(userId: Int, productId: Int) async throws -> WishlistMessage {
        let parameters: [String: Sendable] = [
            "UserId": userId,
            "ProductId": productId
        ]
        
        let request = HerfetyRequest(
            method: .delete,
            path: "api/WishLists",
            parameters: parameters)
        
        return try await enqueue(request)
    }
    
}
// MARK: - Legacy Callback Methods for Backward Compatibility
//
extension ProductsOfWishlistRemote {
    /// .get
    func loadAllProducts(userId: Int, completion: @escaping (Result<[Wishlist], Error>) -> Void) {
        let parameters = ["id": userId]
        let request = HerfetyRequest(
            method: .get,
            path: "api/WishLists",
            parameters: parameters)
        
        enqueue(request, completion: completion)
    }
    /// .post
    func addNewProduct(userId: Int, productId: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        let parameters: [String: Sendable] = [
            "productId": productId,
            "userId": userId
        ]
        
        let request = HerfetyRequest(
            method: .post,
            path: "api/WishLists",
            parameters: parameters,
            destination: .body)
        
        enqueue(request, completion: completion)
    }
    /// .delete
    func removeProduct(userId: Int, productId: Int, completion: @escaping (Result<WishlistMessage, Error>) -> Void) {
        let parameters: [String: Sendable] = [
            "UserId": userId,
            "ProductId": productId
        ]
        
        let request = HerfetyRequest(
            method: .delete,
            path: "api/WishLists",
            parameters: parameters)
        
        enqueue(request, completion: completion)
    }
}
