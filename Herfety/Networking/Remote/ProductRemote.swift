//
//  ProductRemote.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 21/04/2025.
//

import Foundation

protocol ProductRemoteProtocol {
    func loadAllProducts(completion: @escaping (Result<[Productt], Error>) -> Void)
}

class ProductRemote: Remote, ProductRemoteProtocol {
     func loadAllProducts(completion: @escaping (Result<[Productt], Error>) -> Void) {
         let parameters = ["offer": 20]
        let request = HerfetyRequest(method: .get, path: "api/Home/GetOffer",parameters: parameters)
        enqueue(request, completion: completion)
    }
}
