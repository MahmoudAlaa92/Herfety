//
//  WishlistProtocols.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 21/08/2025.
//

import UIKit
import Combine

// MARK: - Wishlist Module Protocols
//
protocol WishlistDataSourceProtocol {
    func getWishlist() async -> [Wishlist]
}

protocol WishlistPublisherProtocol {
    var wishlistUpdatePublisher: AnyPublisher<Bool, Never> { get }
}

protocol WishlistSectionConfiguratorProtocol {
    func configureSections(wishlistItems: [Wishlist]) -> [CollectionViewDataSource]
    func configureLayoutSections() -> [LayoutSectionProvider]
}

// MARK: - Default Implementations
//
class DefaultWishlistDataSource: WishlistDataSourceProtocol {
    func getWishlist() async -> [Wishlist] {
        return await DataStore.shared.getWishlist()
    }
}

class DefaultWishlistPublisher: WishlistPublisherProtocol {
    var wishlistUpdatePublisher: AnyPublisher<Bool, Never> {
        AppDataStorePublisher.shared.wishlistUpdatePublisher
    }
}

class DefaultWishlistSectionConfigurator: WishlistSectionConfiguratorProtocol {
    func configureSections(wishlistItems: [Wishlist]) -> [CollectionViewDataSource] {
        return [WishlistCollectionViewSection(whishlistItems: wishlistItems)]
    }
    
    func configureLayoutSections() -> [LayoutSectionProvider] {
        return [WishlistSectionLayoutProvider()]
    }
}
