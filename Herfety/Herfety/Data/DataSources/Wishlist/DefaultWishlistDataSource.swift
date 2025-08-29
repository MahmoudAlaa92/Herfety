//
//  DefaultWishlistDataSource.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 21/08/2025.
//

import Combine

class DefaultWishlistDataSource: WishlistDataSourceProtocol {
    let dataStore: DataStoreProtocol
    
    init(dataStore: DataStoreProtocol = DataStore.shared) {
        self.dataStore = dataStore
    }
    
    func getWishlist() async -> [WishlistItem] {
        return await dataStore.getWishlist()
    }
}

class DefaultWishlistPublisher: WishlistPublisherProtocol {
    var wishlistUpdatePublisher: AnyPublisher<Bool, Never> {
        AppDataStorePublisher.shared.wishlistUpdatePublisher
    }
}

class DefaultWishlistSectionConfigurator: WishlistSectionConfiguratorProtocol {
    func configureSections(wishlistItems: [WishlistItem]) -> [CollectionViewDataSource] {
        return [WishlistCollectionViewSection(whishlistItems: wishlistItems)]
    }
    
    func configureLayoutSections() -> [LayoutSectionProvider] {
        return [WishlistSectionLayoutProvider()]
    }
}
