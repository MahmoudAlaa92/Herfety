//
//  HomeAlertServiceTests.swift
//  HerfetyTests
//
//  Created by Mahmoud Alaa on 18/08/2025.
//

import XCTest
import Combine
@testable import Herfety

// MARK: - Alert Tests
class HomeAlertServiceTests: XCTestCase {
    var viewModel: HomeViewModel!
    var mockDataSource: MockHomeDataSource!
    var mockAlertService: MockAlertService!
    var mockSectionConfigurator: MockSectionConfigurator!
    var mockCoordinator: MockHomeCoordinator!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockDataSource = MockHomeDataSource()
        mockAlertService = MockAlertService()
        mockSectionConfigurator = MockSectionConfigurator()
        mockCoordinator = MockHomeCoordinator()
        cancellables = Set<AnyCancellable>()
        
        viewModel = HomeViewModel(
            dataSource: mockDataSource,
            alertService: mockAlertService,
            sectionConfigurator: mockSectionConfigurator,
            coordinator: mockCoordinator
        )
    }
    
    override func tearDown() {
        viewModel = nil
        mockDataSource = nil
        mockAlertService = nil
        mockSectionConfigurator = nil
        mockCoordinator = nil
        cancellables = nil
        super.tearDown()
    }
    
    // MARK: - Initialization Tests
    
    func testInitialization() {
        XCTAssertNotNil(viewModel)
        XCTAssertTrue(viewModel.categoryItems.isEmpty)
        XCTAssertTrue(viewModel.productItems.isEmpty)
        XCTAssertNil(viewModel.showAlert)
        XCTAssertFalse(viewModel.sliderItems.isEmpty)
        XCTAssertFalse(viewModel.topBrandsItems.isEmpty)
        XCTAssertFalse(viewModel.dailyEssentialItems.isEmpty)
    }
    
    // MARK: - Alert Service Tests

    func testAlertServiceIntegration() {
        // Arrange
        let expectation = XCTestExpectation(description: "Alert received")
        let testAlert = TestDataFactory.createMockAlert()
        
        // Act
        viewModel
            .$showAlert
            .compactMap { $0 }
            .sink { alert in
                XCTAssertEqual(alert.message, testAlert.message)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        mockAlertService.triggerAlert(testAlert)
        
        // Assert
        wait(for: [expectation], timeout: 1.0) /// Before New (Async/Await)
    }
}
