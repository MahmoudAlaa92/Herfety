//
//  GetProductsOfCategoryRemote.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 25/04/2025.
//

import Foundation

protocol GetProductsOfCatergoryRemoteProtocol {
    func loadAllProducts(name: String ,completion: @escaping (Result<[Products], Error>) -> Void)
}

class GetProductsOfCategoryRemote: Remote, GetProductsOfCatergoryRemoteProtocol, @unchecked Sendable {
    func loadAllProducts(name: String ,completion: @escaping (Result<[Products], Error>) -> Void) {
        let parameters = ["Name": name]
        
        let request = HerfetyRequest(
            method: .get,
            path: "api/Categories/GetProducts",
            parameters: parameters)
        
        enqueue(request, completion: completion)
    }
}

