//
//  CollectionViewSectionProtocols.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 17/04/2025.
//

import UIKit

protocol CollectionViewProvider {
    func registerCells(in collectionView: UICollectionView)
    var numberOfItems: Int { get }
    func cellForItems(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
}
protocol HeaderAndFooterProvider {
    func cellForItems(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
}
protocol LayoutSectionProvider {
    func layoutSection() -> NSCollectionLayoutSection
}

// MARK: - Delegate
//
protocol CollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
}
