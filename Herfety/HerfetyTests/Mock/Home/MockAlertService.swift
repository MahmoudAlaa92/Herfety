//
//  MockAlertService.swift
//  HerfetyTests
//
//  Created by Mahmoud Alaa on 18/08/2025.
//

import Foundation
import Combine
@testable import Herfety

// MARK: Mock Alert Service
class MockAlertService: AlertServiceProtocol {
    @Published private var currentAlert: AlertModel?

    var alertPublisher: AnyPublisher<AlertModel?, Never> {
        $currentAlert.eraseToAnyPublisher()
    }

    var showWishlistAlertCalled = false
    var showCartAlertCalled = false
    var lastWishlistState: Bool?
    var lastCartState: Bool?

    func showWishlistAlert(isAdded: Bool) {
        showWishlistAlertCalled = true
        lastWishlistState = isAdded
        currentAlert = AlertModel(
            message: isAdded ? "Added To Wishlist" : "Deleted From Wishlist",
            buttonTitle: "Ok",
            image: .success,
            status: .success
        )
    }

    func showCartAlert(isAdded: Bool) {
        showCartAlertCalled = true
        lastCartState = isAdded
        currentAlert = AlertModel(
            message: isAdded ? "Added To Order" : "Deleted From Order",
            buttonTitle: "Ok",
            image: .success,
            status: .success
        )
    }

    func triggerAlert(_ alert: AlertModel) {
        currentAlert = alert
    }
}
