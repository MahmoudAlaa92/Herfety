//
//  WishlistRemote.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 29/04/2025.
//

import Foundation


protocol ProductsOfWishlistRemoteProtocol {
    func loadAllProducts(userId: Int, completion: @escaping (Result<[Products], Error>) -> Void)
}

class GetProductsOfWishlistRemote: Remote, ProductsOfWishlistRemoteProtocol {
    /// .get
    func loadAllProducts(userId: Int, completion: @escaping (Result<[Products], Error>) -> Void) {
        let parameters = ["id": userId]
        let request = HerfetyRequest(method: .get, path: "api/WishLists", parameters: parameters)
        enqueue(request, completion: completion)
    }
    /// .post
    func addNewProduct(userId: Int, productId: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        let parameters: [String: Sendable] = [
            "productId": productId,
            "userId": userId
        ]
        
        let request = HerfetyRequest(method: .post, path: "api/WishLists", parameters: parameters)
        enqueue(request, completion: completion)
    }

}

