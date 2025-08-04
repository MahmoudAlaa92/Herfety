//
//  ProductRemote.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 21/04/2025.
//

import Foundation

protocol OfferRemoteProtocol {
    func loadAllOffer(completion: @escaping (Result<[Products], Error>) -> Void)
    func loadSpecificOffer(disount:Int ,completion: @escaping (Result<[Products], Error>) -> Void)
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
