//
//  CategoryRemote.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 23/04/2025.
//

import Foundation

protocol CategoryRemoteProtocol {
    /// Async/await versions
    func loadAllCategories() async throws -> [CategoryElement]
    /// Legacy callback versions for backward compatibility
    func loadAllCategories(completion: @escaping (Result<[CategoryElement], Error>) -> Void)
}

class CategoryRemote: Remote, CategoryRemoteProtocol, @unchecked Sendable {
    func loadAllCategories(completion: @escaping (Result<[CategoryElement], Error>) -> Void) {
        
        let request = HerfetyRequest(
            method: .get,
            path: "api/Categories/")
        
        enqueue(request, completion: completion)
    }
}
// MARK: - Modern Async/Await Methods
//
extension CategoryRemote {
    func loadAllCategories() async throws -> [CategoryElement] {
        
        let request = HerfetyRequest(
            method: .get,
            path: "api/Categories/")
        
        return try await enqueue(request)
    }
}
