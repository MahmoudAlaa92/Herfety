//
//  MockCategoryRemote.swift
//  HerfetyTests
//
//  Created by Mahmoud Alaa on 18/08/2025.
//

import XCTest
@testable import Herfety

// MARK: Mock Category Remote
class MockCategoryRemote: CategoryRemoteProtocol {
    var categoryResult: Result<[CategoryElement], Error> = .success(TestDataFactory.createMockCategories())
    var loadAllCategoriesCalled = false

    func loadAllCategories() async throws -> [CategoryElement] {
        loadAllCategoriesCalled = true
        switch categoryResult {
        case .success(let category):
            return category
        case .failure(let error):
            throw error
        }
    }
    func loadAllCategories(completion: @escaping (Result<[CategoryElement], Error>) -> Void) {}
}
