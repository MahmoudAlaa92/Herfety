//
//  DefaultWishlistDataSource.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 21/08/2025.
//

import Combine

// MARK: - DataSource
class DefaultWishlistDataSource: WishlistDataSourceProtocol {
    let dataStore: DataStoreProtocol
    
    init(dataStore: DataStoreProtocol = DataStore.shared) {
        self.dataStore = dataStore
    }
    
    func getWishlist() async -> [WishlistItem] {
        return await dataStore.getWishlist()
    }
}
// MARK: - Configuration
//
class DefaultWishlistSectionConfigurator: WishlistSectionConfiguratorProtocol {
    let deleteItemSubject = PassthroughSubject<WishlistItem, Never>()
    private var cancellables: Set<AnyCancellable> = []
    
    var deleteItemPublisher: AnyPublisher<WishlistItem, Never> {
        deleteItemSubject.eraseToAnyPublisher()
    }
    
    func configureSections(wishlistItems: [WishlistItem]) -> [CollectionViewDataSource] {
        
        let wishlistSection = [WishlistCollectionViewSection(whishlistItems: wishlistItems)]
        
        wishlistSection[0].deleteItemSubject.sink { [weak self] WishlistItem in
            self?.deleteItemSubject.send(WishlistItem)
        }.store(in: &cancellables)
        
        return wishlistSection
    }
    
    func configureLayoutSections() -> [LayoutSectionProvider] {
        return [WishlistSectionLayoutProvider()]
    }
}
// MARK: - Publishers
//
class DefaultWishlistPublisher: WishlistPublisherProtocol {
    var wishlistUpdatePublisher: AnyPublisher<Bool, Never> {
        AppDataStorePublisher.shared.wishlistUpdatePublisher
    }
}
