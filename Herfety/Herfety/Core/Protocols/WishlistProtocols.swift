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
    func getWishlist() async -> [WishlistItem]
}

protocol WishlistPublisherProtocol {
    var wishlistUpdatePublisher: AnyPublisher<Bool, Never> { get }
}

protocol WishlistSectionConfiguratorProtocol {
    var deleteItemPublisher: AnyPublisher<WishlistItem, Never> { get }

    func configureSections(wishlistItems: [WishlistItem]) -> [CollectionViewDataSource]
    
    func configureLayoutSections() -> [LayoutSectionProvider]
}
