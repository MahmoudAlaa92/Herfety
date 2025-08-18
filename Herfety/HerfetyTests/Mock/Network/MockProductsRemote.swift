//
//  MockProductsRemote.swift
//  HerfetyTests
//
//  Created by Mahmoud Alaa on 18/08/2025.
//

import XCTest
@testable import Herfety

//
class MockProductsRemote: ProductsRemoteProtocol {
    
    var productsResult: Result<[Products], Error> = .success(TestDataFactory.createMockProducts())
    var loadAllProdcutsCalled = false
    
    func loadAllProducts() async throws -> [Products] {
        loadAllProdcutsCalled = true
        switch productsResult {
        case .success(let products):
            return products
        case .failure(let error):
            throw error
        }
    }
    
    func loadAllProducts(completion: @escaping (Result<[Products], Error>) -> Void) {}
}

