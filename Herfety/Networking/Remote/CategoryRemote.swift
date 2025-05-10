//
//  CategoryRemote.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 23/04/2025.
//

import Foundation

protocol CategoryRemoteProtocol {
    func loadAllCategories(completion: @escaping (Result<[CategoryElement], Error>) -> Void)
}

class CategoryRemote: Remote, CategoryRemoteProtocol {
    func loadAllCategories(completion: @escaping (Result<[CategoryElement], Error>) -> Void) {
        
        let request = HerfetyRequest(
            method: .get,
            path: "api/Categories/")
        
        enqueue(request, completion: completion)
    }
}
