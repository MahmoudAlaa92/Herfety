//
//  WishlistViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 11/08/2025.
//

import UIKit
import Combine

final class WishListViewModel {
    
    // MARK: - Published Properties
    @Published private(set) var sections: [CollectionViewDataSource] = []
    @Published private(set) var layoutProviders: [LayoutSectionProvider] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    init() {
        bindWishlistUpdates()
        layoutProviders.append(WishlistSectionLayoutProvider())
    }
}
// MARK: - Bind to Data Store Publisher
//
extension WishListViewModel {
    private func bindWishlistUpdates() {
        AppDataStorePublisher
            .shared
            .wishlistUpdatePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                Task {
                    let wishlist = await DataStore.shared.getWishlist()
                    self?.sections = [WishlistCollectionViewSection(whishlistItems: wishlist)]
                }
            }
            .store(in: &cancellables)
    }
}
// MARK: - Public Methods
//
extension WishListViewModel {
    func numberOfSections() -> Int {
        return sections.count
    }
    
    func numberOfItems(in section: Int) -> Int {
        return sections[section].numberOfItems
    }
    
    func section(at index: Int) -> CollectionViewDataSource {
        return sections[index]
    }
    
    func getLayoutProviders() -> [LayoutSectionProvider] {
        return layoutProviders
    }
}

