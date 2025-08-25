//
//  HomeAlertService.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 16/08/2025.
//

import Foundation
import Combine

class HomeAlertService: AlertServiceProtocol {
    @Published private var currentAlert: AlertModel?
    private let publisherManager: AppDataStorePublisher
    private var cancellables = Set<AnyCancellable>()
    
    var alertPublisher: AnyPublisher<AlertModel?, Never> {
        $currentAlert.eraseToAnyPublisher()
    }
    
    init(publisherManager: AppDataStorePublisher) {
        self.publisherManager = publisherManager
        observeWishlistUpdates()
        observeCartUpdates()
    }
    
    func showWishlistAlert(isAdded: Bool) {
        currentAlert = AlertModel(
            message: isAdded ? L10n.Cart.addedToWishlist : L10n.Cart.deletedFromWishlist,
            buttonTitle: L10n.General.ok,
            image: .success,
            status: .success
        )
    }
    
    func showCartAlert(isAdded: Bool) {
        currentAlert = AlertModel(
            message: isAdded ? L10n.Cart.addedToOrder : L10n.Cart.deletedFromOrder,
            buttonTitle: L10n.General.ok,
            image: .success,
            status: .success
        )
    }
    
    private func observeWishlistUpdates() {
        publisherManager
            .wishlistUpdatePublisher
            .dropFirst(2)
            .sink { [weak self] isAdded in
                self?.showWishlistAlert(isAdded: isAdded)
            }
            .store(in: &cancellables)
    }
    
    private func observeCartUpdates() {
        publisherManager
            .cartUpdatePublisher
            .sink { [weak self] isAdded in
                self?.showCartAlert(isAdded: isAdded)
            }
            .store(in: &cancellables)
    }
}
