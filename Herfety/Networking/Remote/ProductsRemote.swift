//
//  ProductsRemote.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 23/04/2025.
//

import Foundation

protocol ProductsRemoteProtocol {
    func loadAllProducts(completion: @escaping (Result<[Products], Error>) -> Void)
}

class ProductsRemote: Remote, ProductsRemoteProtocol {
    func loadAllProducts(completion: @escaping (Result<[Products], Error>) -> Void) {
        let request = HerfetyRequest(method: .get, path: "api/Home/Offers")
        enqueue(request, completion: completion)
    }
}
