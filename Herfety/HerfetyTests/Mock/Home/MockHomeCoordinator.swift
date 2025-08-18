//
//  MockHomeCoordinator.swift
//  HerfetyTests
//
//  Created by Mahmoud Alaa on 18/08/2025.
//

import XCTest
@testable import Herfety

// MARK: Mock Coordinator
class MockHomeCoordinator: HomeTranisitionProtocol {
    var goToSliderItemCalled = false
    var goToCategoryItemCalled = false
    var gotToBestDealItemCalled = false
    var gotToTopBrandItemCalled = false
    var gotToDailyEssentialItemCalled = false
    var goToSearchCalled = false
    var goToSafariCalled = false
    var goToBestDealItemCalled = false

    var lastSliderDiscount: Int?
    var lastCategory: String?
    var lastProductDetails: Products?
    var lastTopBrandDiscount: Int?
    var lastDailyEssentialDiscount: Int?

    func goToSliderItem(discount: Int) {
        goToSliderItemCalled = true
        lastSliderDiscount = discount
    }

    func goToCategoryItem(category: String) {
        goToCategoryItemCalled = true
        lastCategory = category
    }

    func gotToBestDealItem(productDetails: Products) {
        gotToBestDealItemCalled = true
        lastProductDetails = productDetails
    }

    func gotToTopBrandItem(discount: Int) {
        gotToTopBrandItemCalled = true
        lastTopBrandDiscount = discount
    }

    func gotToDailyEssentialItem(discount: Int) {
        gotToDailyEssentialItemCalled = true
        lastDailyEssentialDiscount = discount
    }

    func goToSearchVC(discount: Int) {
        goToSafariCalled = true
    }

    func gotToSafari(url: String) {
        goToSafariCalled = true
    }

    func gotToBestDealItem(productDetails: Herfety.Wishlist) {
        goToBestDealItemCalled = true
    }
}
