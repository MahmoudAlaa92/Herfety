//
//  HomeSectionConfiguratorTests.swift
//  HerfetyTests
//
//  Created by Mahmoud Alaa on 18/08/2025.
//

import XCTest
@testable import Herfety

// MARK: - HomeSectionConfigurator Tests

class HomeSectionConfiguratorTests: XCTestCase {
    var sectionConfigurator: HomeSectionConfigurator!
    var mockCoordinator: MockHomeCoordinator!
    
    override func setUp() {
        super.setUp()
        sectionConfigurator = HomeSectionConfigurator()
        mockCoordinator = MockHomeCoordinator()
    }
    
    override func tearDown() {
        sectionConfigurator = nil
        mockCoordinator = nil
        super.tearDown()
    }
    
    func testConfigureSections() {
        // Arrange
        let sliderItems = TestDataFactory.createMockSliderItems()
        let categoryItems = TestDataFactory.createMockCategories()
        let productItems = TestDataFactory.createMockProducts()
        let topBrandsItems = HomeStaticDataProvider.createTopBrandsItems()
        let dailyEssentialItems = HomeStaticDataProvider.createDailyEssentialItems()
        
        // Act
        let sections = sectionConfigurator.configureSections(
            sliderItems: sliderItems,
            categoryItems: categoryItems,
            productItems: productItems,
            topBrandsItems: topBrandsItems,
            dailyEssentialItems: dailyEssentialItems,
            coordinator: mockCoordinator
        )
        
        // Assert
        XCTAssertEqual(sections.count, 5) /// slider, category, card, topBrands, dailyEssentials
    }
    
    func testConfigureLayoutSections() {
        // Act
        let layoutSections = sectionConfigurator.configureLayoutSections()
        
        // Assert
        XCTAssertEqual(layoutSections.count, 5) /// All layout providers
    }
}
