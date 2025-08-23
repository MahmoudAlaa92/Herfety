//
//  DataActor.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 07/08/2025.
//

import Foundation

// MARK: - Data Actor (Thread-safe)
//
actor DataActor: DataActorProtocol {
    private let productService: ProductsOfWishlistRemoteProtocol
    
    init() {
        self.productService = ProductsOfWishlistRemote(network: AlamofireNetwork())
    }
    
    func fetchWishlistProducts(userId: Int) async throws -> [WishlistItem] {
        return try await productService.loadAllProducts(userId: userId)
    }
    
    func removeWishlistProduct(userId: Int, productId: Int) async throws {
        _ = try await productService.removeProduct(userId: userId, productId: productId)
    }
    
    func addWishlistProduct(userId: Int, productId: Int) async throws {
        _ = try await productService.addNewProduct(userId: userId, productId: productId)
    }
}

