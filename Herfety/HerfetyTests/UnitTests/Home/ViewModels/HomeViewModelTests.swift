//
//  HomeTests.swift
//  HerfetyTests
//
//  Created by Mahmoud Alaa on 17/08/2025.
//

import XCTest
import Combine
@testable import Herfety

// MARK: - HomeViewModel Tests
class HomeViewModelTests: XCTestCase {
    var viewModel: HomeViewModel!
    var dataSource: HomeDataSource!
    var mockDataSource: MockHomeDataSource!
    var mockAlertService: MockAlertService!
    var mockCategoryRemote: MockCategoryRemote!
    var mockProdcutsRemote: MockProductsRemote!
    var mockSectionConfigurator: MockSectionConfigurator!
    var mockCoordinator: MockHomeCoordinator!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockCategoryRemote = MockCategoryRemote()
        mockProdcutsRemote = MockProductsRemote()
        dataSource = HomeDataSource(categoryRemote: mockCategoryRemote,
                                    productsRemote: mockProdcutsRemote)
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
        mockCategoryRemote = nil
        mockProdcutsRemote = nil
        dataSource = nil
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
    
    // MARK: - Data Fetching Tests
    
    func testFetchDataSuccess() async {
        // Arrange
        let expectedCategories = TestDataFactory.createMockCategories()
        let expectedProducts = TestDataFactory.createMockProducts()
        mockDataSource.categoriesResult = .success(expectedCategories)
        mockDataSource.productsResult = .success(expectedProducts)
        
        // Act
        await viewModel.fetchData()
        
        // Assert
        XCTAssertTrue(mockDataSource.fetchCategoriesCalled)
        XCTAssertTrue(mockDataSource.fetchProductsCalled)
        XCTAssertEqual(viewModel.categoryItems.count, expectedCategories.count)
        XCTAssertEqual(viewModel.productItems.count, expectedProducts.count)
        XCTAssertTrue(mockSectionConfigurator.configureSectionsCalled)
    }
    
    func testFetchCategoriesFailure() async {
        // Arrange
        let expectedError = NSError(domain: "TestError", code: 404, userInfo: [NSLocalizedDescriptionKey: "Categories not found"])
        mockDataSource.categoriesResult = .failure(expectedError)
        
        // Act
        await viewModel.fetchData()
        
        // Assert
        XCTAssertTrue(mockDataSource.fetchCategoriesCalled)
        XCTAssertTrue(viewModel.categoryItems.isEmpty)
    }
    
    func testFetchProductsFailure() async {
        // Arrange
        let expectedError = NSError(domain: "TestError", code: 404, userInfo: [NSLocalizedDescriptionKey: "Products not found"])
        mockDataSource.productsResult = .failure(expectedError)
        
        // Act
        await viewModel.fetchData()
        
        // Assert
        XCTAssertTrue(mockDataSource.fetchProductsCalled)
        XCTAssertTrue(viewModel.productItems.isEmpty)
    }
    
    // MARK: - Section Configuration Tests
    
    func testNumberOfSections() {
        let expectedSections = HomeSection.allCases.count
        XCTAssertEqual(viewModel.numberOfSections(), expectedSections)
    }
    
    func testNumberOfItemsInSliderSection() {
        let sliderSection = HomeSection.slider.rawValue
        let expectedCount = viewModel.sliderItems.count
        XCTAssertEqual(viewModel.numberOfItems(in: sliderSection), expectedCount)
    }
    
    func testNumberOfItemsInCategoriesSection() {
        // Arrange
        viewModel.categoryItems = TestDataFactory.createMockCategories()
        
        // Act & Assert
        let categoriesSection = HomeSection.categories.rawValue
        let expectedCount = viewModel.categoryItems.count
        XCTAssertEqual(viewModel.numberOfItems(in: categoriesSection), expectedCount)
    }
    
    func testNumberOfItemsInProductsSection() {
        // Arrange
        viewModel.productItems = TestDataFactory.createMockProducts()
        
        // Act & Assert
        let productsSection = HomeSection.products.rawValue
        let expectedCount = viewModel.productItems.count
        XCTAssertEqual(viewModel.numberOfItems(in: productsSection), expectedCount)
    }
    
    func testNumberOfItemsInDailyEssentialsSection() {
        let dailyEssentialsSection = HomeSection.dailyEssentials.rawValue
        let expectedCount = viewModel.dailyEssentialItems.count
        XCTAssertEqual(viewModel.numberOfItems(in: dailyEssentialsSection), expectedCount)
    }
    
    func testNumberOfItemsInvalidSection() {
        let invalidSection = 1902
        XCTAssertEqual(viewModel.numberOfItems(in: invalidSection), 0)
    }
    
    // MARK: - Integration Tests
    
    func testCompleteDataFlow() async {
        // Arrange
        let expectedCategories = TestDataFactory.createMockCategories()
        let expectedProducts = TestDataFactory.createMockProducts()
        mockDataSource.categoriesResult = .success(expectedCategories)
        mockDataSource.productsResult = .success(expectedProducts)
        
        let sectionsExpectation = XCTestExpectation(description: "Sections updated")
        
        viewModel
            .$sections
            .dropFirst() /// Skip initial empty array
            .sink { sections in
                sectionsExpectation.fulfill()
            }
            .store(in: &cancellables)
        
        // Act
        await viewModel.fetchData()
        
        // Assert
        await fulfillment(of: [sectionsExpectation], timeout: 2.0) /// For New (Async/Await)
        XCTAssertTrue(mockDataSource.fetchCategoriesCalled)
        XCTAssertTrue(mockDataSource.fetchProductsCalled)
        XCTAssertTrue(mockSectionConfigurator.configureSectionsCalled)
        XCTAssertEqual(viewModel.categoryItems.count, expectedCategories.count)
        XCTAssertEqual(viewModel.productItems.count, expectedProducts.count)
    }
    
    // MARK: - Category Remote Tests
    
    func testFetchCategoriesSuccess() async throws {
        // Arrange
        let expectedCategories = TestDataFactory.createMockCategories()
        mockCategoryRemote.categoryResult = .success(expectedCategories)
        
        // Act
        let result = try await dataSource.fetchCategories()
        
        // Assert
        XCTAssertTrue(mockCategoryRemote.loadAllCategoriesCalled)
        XCTAssertEqual(result.count, expectedCategories.count)
        XCTAssertEqual(result.first?.name, expectedCategories.first?.name)
    }
    
}
