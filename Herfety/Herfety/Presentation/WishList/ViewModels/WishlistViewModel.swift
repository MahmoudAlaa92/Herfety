//
//  WishlistViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 11/08/2025.
//

import UIKit
import Combine

final class WishListViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published private(set) var sections: [CollectionViewDataSource] = []
    @Published private(set) var layoutProviders: [LayoutSectionProvider] = []
    
    // MARK: - Dependencies
    private let dataSource: WishlistDataSourceProtocol
    private let publisher: WishlistPublisherProtocol
    private let sectionConfigurator: WishlistSectionConfiguratorProtocol
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    init(
        dataSource: WishlistDataSourceProtocol = DefaultWishlistDataSource(),
        publisher: WishlistPublisherProtocol = DefaultWishlistPublisher(),
        sectionConfigurator: WishlistSectionConfiguratorProtocol = DefaultWishlistSectionConfigurator()
    ) {
        self.dataSource = dataSource
        self.publisher = publisher
        self.sectionConfigurator = sectionConfigurator
        
        setupLayoutProviders()
        listenWishlistSectionUpdates()
    }
}
// MARK: - Public Methods
//
extension WishListViewModel {
    func loadWishlistData(item: WishlistItem?) async {
        var wishlist = await dataSource.getWishlist()
        
        if let itemToRemove = item,
           let index = wishlist.firstIndex(where: { $0.productID == itemToRemove.productID}) {
            wishlist.remove(at: index)
        }
        await updateSections(with: wishlist)
    }
    
    @MainActor
    private func updateSections(with wishlist: [WishlistItem]) {
        sections = sectionConfigurator.configureSections(wishlistItems: wishlist)
    }
}
// MARK: - Private Methods
//
extension WishListViewModel {
    private func setupLayoutProviders() {
        layoutProviders = sectionConfigurator.configureLayoutSections()
    }
    
    private func listenWishlistSectionUpdates() {
        sectionConfigurator
            .deleteItemPublisher
            .sink { [weak self] WishlistItem in
                guard let self = self else { return }
                Task { await self.loadWishlistData(item: WishlistItem)}
                print("YES")
            }
            .store(in: &cancellables)
    }
}
