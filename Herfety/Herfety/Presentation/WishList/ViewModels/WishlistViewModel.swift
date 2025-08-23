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
        bindWishlistUpdates()
    }
}

// MARK: - Public Methods
//
extension WishListViewModel {
    func loadWishlistData() async {
        let wishlist = await dataSource.getWishlist()
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
    
    private func bindWishlistUpdates() {
        publisher
            .wishlistUpdatePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                Task {
                    await self?.loadWishlistData()
                }
            }
            .store(in: &cancellables)
    }
}
