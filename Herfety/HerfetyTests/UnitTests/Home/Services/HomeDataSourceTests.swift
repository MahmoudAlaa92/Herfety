//
//  HomeDataSourceTests.swift
//  HerfetyTests
//
//  Created by Mahmoud Alaa on 18/08/2025.
//

import XCTest
import Combine
@testable import Herfety

// MARK: - Home Data Source Tests
class HomeDataSourceTests: XCTestCase {
    var dataSource: MockHomeDataSource!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        dataSource = MockHomeDataSource()
    }
    
    override func tearDown() {
        dataSource = nil
        cancellables = nil
        super.tearDown()
    }
    
    // MARK: - Initialization Tests
    
    func testInitialization() {
        XCTAssertNotNil(dataSource)
    }
    
    func testDataSource() async throws {
        // Arrange
        let expectedCategory = TestDataFactory.createMockCategories()
        let expectedProducts = TestDataFactory.createMockProducts()
        
        // Act
        let categoryResult = try await dataSource.fetchCategories()
        let productResult = try await dataSource.fetchProducts()
        
        // Assert
        XCTAssertEqual(categoryResult.count, expectedCategory.count)
        XCTAssertEqual(productResult.count, expectedProducts.count)
        XCTAssertTrue(dataSource.fetchCategoriesCalled)
        XCTAssertTrue(dataSource.fetchProductsCalled)
    }
}
