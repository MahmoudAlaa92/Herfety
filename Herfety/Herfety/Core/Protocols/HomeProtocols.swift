//
//  HomeProtocols.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 16/08/2025.
//

import UIKit
import Combine

// MARK: - Home Module Protocols
//
protocol HomeDataSourceProtocol {
    func fetchCategories() async throws -> [CategoryElement]
    func fetchProducts() async throws -> [Products]
}

protocol AlertServiceProtocol {
    var alertPublisher: AnyPublisher<AlertModel?, Never> { get }
    func showWishlistAlert(isAdded: Bool)
    func showCartAlert(isAdded: Bool)
}

protocol HomeSectionConfiguratorProtocol {
    func configureSections(
        sliderItems: [SliderItem],
        categoryItems: [CategoryElement],
        productItems: [Products],
        topBrandsItems: [TopBrandsItem],
        dailyEssentialItems: [DailyEssentialyItem],
        coordinator: HomeTranisitionProtocol
    ) -> [CollectionViewDataSource]
    
    func configureLayoutSections() -> [LayoutSectionProvider]
}
// MARK: - Collection View Protocols
//
protocol CollectionViewDataSource: AnyObject {
    func registerCells(in collectionView: UICollectionView)
    var numberOfItems: Int { get }
    func cellForItems(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
}

protocol CollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
}

protocol ContextMenuProvider {
    func contextMenuConfiguration(for collectionView: UICollectionView, at indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration?
}

protocol HeaderAndFooterProvider {
    func cellForItems(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
}
// MARK: - Layout
//
protocol LayoutSectionProvider {
    func layoutSection() -> NSCollectionLayoutSection
}
