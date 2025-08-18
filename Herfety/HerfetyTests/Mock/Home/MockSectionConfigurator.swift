//
//  MockSectionConfigurator.swift
//  HerfetyTests
//
//  Created by Mahmoud Alaa on 18/08/2025.
//

import XCTest
@testable import Herfety

// MARK: Mock Section Configurator
class MockSectionConfigurator: HomeSectionConfiguratorProtocol {
    var configureSectionsCalled = false
    var configureLayoutSectionsCalled = false

    var mockSections: [CollectionViewDataSource] = []
    var mockLayoutSections: [LayoutSectionProvider] = []

    func configureSections(
        sliderItems: [SliderItem],
        categoryItems: [CategoryElement],
        productItems: [Products],
        topBrandsItems: [TopBrandsItem],
        dailyEssentialItems: [DailyEssentialyItem],
        coordinator: HomeTranisitionProtocol
    ) -> [CollectionViewDataSource] {
        configureSectionsCalled = true
        return mockSections
    }

    func configureLayoutSections() -> [LayoutSectionProvider] {
        configureLayoutSectionsCalled = true
        return mockLayoutSections
    }
}
