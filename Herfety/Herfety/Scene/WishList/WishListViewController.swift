//
//  WishListViewController.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 09/02/2025.
//

import UIKit

class WishListViewController: UIViewController {

    // MARK: - Properties
    //
    private let viewModel = WishListViewModel()
    private var providers = [CollectionViewProvider]()
    private var layoutProviders = [SectionLayoutProvider]()
    
    // MARK: - Outlets
    //
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureProvider()
        cofigureCompositianalLayout()
        setUpCollectionView()
        view.backgroundColor = Colors.hBackgroundColor

    }
}
// MARK: - Configure
//
extension WishListViewController {
    
    /// Configure Provider
    private func configureProvider() {
        let wishListProvider = WishlistCollectionViewSection(whishlistItems: viewModel.wishlistItems)
        providers = [wishListProvider]
        
        layoutProviders.append(WishlistSectionLayoutProvider())
    }
    
    private func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        providers.forEach { $0.registerCells(in: collectionView) }
    }
    
    /// Configure Layout
    private func cofigureCompositianalLayout() {
        let layoutFactory = SectionsLayout(providers: layoutProviders)
        self.collectionView.setCollectionViewLayout(layoutFactory.createLayout(), animated: true)
    }
}

// MARK: - UICollectionViewDelegate
//
extension WishListViewController: UICollectionViewDelegate {}

// MARK: - UICollectionViewDataSource
//
extension WishListViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return providers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        providers[section].numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return providers[indexPath.section].cellForItems(collectionView, cellForItemAt: indexPath)
    }
}

// MARK: - Header And Footer
//
extension WishListViewController {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let provider = providers[indexPath.section] as? HeaderAndFooterProvider {
            return provider.cellForItems(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath)
        }
        return UICollectionReusableView()
    }
}
