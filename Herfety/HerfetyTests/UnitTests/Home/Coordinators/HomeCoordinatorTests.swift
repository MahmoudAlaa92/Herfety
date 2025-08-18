//
//  HomeCoordinatorTests.swift
//  HerfetyTests
//
//  Created by Mahmoud Alaa on 18/08/2025.
//

import XCTest
@testable import Herfety

class HomeCoordinatorTests: XCTestCase {
    var mockCoordinator: MockHomeCoordinator!
    
    override func setUp() {
        super.setUp()
        mockCoordinator = MockHomeCoordinator()
    }
    
    override func tearDown() {
        mockCoordinator = nil
        super.tearDown()
    }
    
    // MARK: - Coordinator Tests
    
    func testCoordintorFlow() {
        // Arrange
        mockCoordinator.goToSliderItem(discount: 10)
        
        // Assert
        XCTAssertEqual(10, mockCoordinator.lastSliderDiscount)
        XCTAssertTrue(mockCoordinator.goToSliderItemCalled)
    }
}
