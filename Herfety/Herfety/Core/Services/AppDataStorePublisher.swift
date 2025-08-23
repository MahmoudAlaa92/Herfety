//
//  AppDataStorePublisher.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 07/08/2025.
//

import Foundation
import Combine

// MARK: - Publisher Manager (MainActor isolated)
//
class AppDataStorePublisher: ObservableObject, AppDataStorePublisherProtocol {
    static let shared = AppDataStorePublisher()
    
    @Published var wishlistUpdated: Bool = false
    @Published var ordersUpdated: Bool = false
    @Published var cartUpdated: Bool = false
    @Published var infoUpdated: Bool = false
    @Published var loginStatusUpdated: Bool = false
    @Published var userProfileImage: Bool = false
    
    private init() {}
    
    func notifyWishlistUpdate(showAlert: Bool) {
        wishlistUpdated = showAlert
    }
    
    func notifyOrdersUpdate() {
        ordersUpdated.toggle()
    }
    
    func notifyCartUpdate(showAlert: Bool) {
        cartUpdated = showAlert
    }
    
    func notifyInfoUpdate() {
        infoUpdated.toggle()
    }
    
    func notifyLoginStatusUpdate() {
        loginStatusUpdated.toggle()
    }
    
    func notifyProfileImageUpdate() {
        userProfileImage.toggle()
    }
}
// MARK: - Publisher Extensions
//
extension AppDataStorePublisher: PublisherExtensionsProtocol {
    var wishlistUpdatePublisher: AnyPublisher<Bool, Never> {
        $wishlistUpdated.eraseToAnyPublisher()
    }
    
    var ordersUpdatePublisher: AnyPublisher<Bool, Never> {
        $ordersUpdated.eraseToAnyPublisher()
    }
    
    var cartUpdatePublisher: AnyPublisher<Bool, Never> {
        $cartUpdated.eraseToAnyPublisher()
    }
    
    var infoUpdatePublisher: AnyPublisher<Bool, Never> {
        $infoUpdated.eraseToAnyPublisher()
    }
    
    var loginStatusPublisher: AnyPublisher<Bool, Never> {
        $loginStatusUpdated.eraseToAnyPublisher()
    }
    
    var profileImageStatusPublisher: AnyPublisher<Bool, Never> {
        $userProfileImage.eraseToAnyPublisher()
    }
}
