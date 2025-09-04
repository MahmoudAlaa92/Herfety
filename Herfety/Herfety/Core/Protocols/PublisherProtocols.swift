//
//  PublisherProtocols.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 07/08/2025.
//

import Foundation
import Combine

// MARK: - Publisher Manager Protocol

protocol AppDataStorePublisherProtocol: ObservableObject {
    var wishlistUpdated: Bool { get set }
    var ordersUpdated: Bool { get set }
    var cartUpdated: CartUpdateAction { get set }
    var infoUpdated: Bool { get set }
    var loginStatusUpdated: Bool { get set }
    var userProfileImage: Bool { get set }
    
    func notifyWishlistUpdate(showAlert: Bool)
    func notifyOrdersUpdate()
    func notifyCartUpdate(showAlert: CartUpdateAction)
    func notifyInfoUpdate()
    func notifyLoginStatusUpdate()
    func notifyProfileImageUpdate()
}

// MARK: - Publisher Extensions Protocol
protocol PublisherExtensionsProtocol {
    var wishlistUpdatePublisher: AnyPublisher<Bool, Never> { get }
    var ordersUpdatePublisher: AnyPublisher<Bool, Never> { get }
    var cartUpdatePublisher: AnyPublisher<CartUpdateAction, Never> { get }
    var infoUpdatePublisher: AnyPublisher<Bool, Never> { get }
    var loginStatusPublisher: AnyPublisher<Bool, Never> { get }
    var profileImageStatusPublisher: AnyPublisher<Bool, Never> { get }
}
