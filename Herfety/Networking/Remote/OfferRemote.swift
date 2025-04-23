//
//  ProductRemote.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 21/04/2025.
//

import Foundation

protocol OfferRemoteProtocol {
    func loadAllOffer(completion: @escaping (Result<[Offer], Error>) -> Void)
}

class ProductRemote: Remote, OfferRemoteProtocol {
     func loadAllOffer(completion: @escaping (Result<[Offer], Error>) -> Void) {
         let parameters = ["offer": 20]
        let request = HerfetyRequest(method: .get, path: "api/Home/GetOffer",parameters: parameters)
        enqueue(request, completion: completion)
    }
}
