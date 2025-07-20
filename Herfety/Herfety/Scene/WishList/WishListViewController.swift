//
//  WishListViewController.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 09/02/2025.
//

import UIKit

class WishListViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    private var navigationBarBehavior: HerfetyNavigationController?
    private var sections = [CollectionViewDataSource]()
    private var layoutProviders = [LayoutSectionProvider]()
    var isShowBackButton = false
    ///
    weak var coordinator: WishlistTransitionDelegate?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        configureProvider()
        cofigureCompositianalLayout()
        setUpCollectionView()
        view.backgroundColor = Colors.hBackgroundColor
    }
}
// MARK: - Configure
//
extension WishListViewController {
    /// Set up Navigation Bar
    private func setUpNavigationBar() {

        navigationItem.backButtonTitle = ""

        navigationBarBehavior = HerfetyNavigationController(
            navigationItem: navigationItem,
            navigationController: navigationController
        )

        navigationBarBehavior?.configure(
            title: "",
            titleColor: .primaryBlue,
            onPlus: { },
            showRighBtn: false,
            showBackButton: isShowBackButton) { [weak self] in
                 self?.coordinator?.backToProfileVC()
            }
    }
    /// Configure Provider
    private func configureProvider() {
        CustomeTabBarViewModel
            .shared
            .$Wishlist
            .sink { [weak self] value in
            let wishListProvider = WishlistCollectionViewSection(whishlistItems: value)
            self?.sections = [wishListProvider]
            self?.collectionView.reloadData()
        }.store(in: &CustomeTabBarViewModel.shared.subscriptions)
        layoutProviders.append(WishlistSectionLayoutProvider())
    }
    
    private func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        sections.forEach { $0.registerCells(in: collectionView) }
    }
    
    /// Configure Layout
    private func cofigureCompositianalLayout() {

        let layoutFactory = SectionsLayout(providers: layoutProviders)
        self.collectionView.setCollectionViewLayout(layoutFactory.createLayout(), animated: true)
    }
}

// MARK: - UICollectionViewDelegate
//
extension WishListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        contextMenuConfigurationForItemAt indexPath: IndexPath,
                        point: CGPoint) -> UIContextMenuConfiguration? {
        if let providers = sections[indexPath.section] as? ContextMenuProvider {
            return providers.contextMenuConfiguration(for: collectionView, at: indexPath, point: point)
        }
        return nil
    }
}

// MARK: - UICollectionViewDataSource
//
extension WishListViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return sections[indexPath.section].cellForItems(collectionView, cellForItemAt: indexPath)
    }
}

// MARK: - Header And Footer
//
extension WishListViewController {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let provider = sections[indexPath.section] as? HeaderAndFooterProvider {
            return provider.cellForItems(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath)
        }
        return UICollectionReusableView()
    }
}
