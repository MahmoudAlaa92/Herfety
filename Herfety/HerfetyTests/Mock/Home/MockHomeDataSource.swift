//
//  MockHomeDataSource.swift
//  HerfetyTests
//
//  Created by Mahmoud Alaa on 18/08/2025.
//

import XCTest
@testable import Herfety
// MARK: Mock Data Source
class MockHomeDataSource: HomeDataSourceProtocol {
    var categoriesResult: Result<[CategoryElement], Error> = .success(
        TestDataFactory.createMockCategories()
    )
    var productsResult: Result<[Products], Error> = .success(
        TestDataFactory.createMockProducts()
    )

    var fetchCategoriesCalled = false
    var fetchProductsCalled = false

    func fetchCategories() async throws -> [CategoryElement] {
        fetchCategoriesCalled = true
        switch categoriesResult {
        case .success(let categories):
            return categories
        case .failure(let error):
            throw error
        }
    }

    func fetchProducts() async throws -> [Products] {
        fetchProductsCalled = true
        switch productsResult {
        case .success(let products):
            return products
        case .failure(let error):
            throw error
        }
    }
}
