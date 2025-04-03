//
//  SettingCollectionViewSection.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 03/04/2025.
//

import UIKit

class SettingCollectionViewSection: CollectionViewProvider {
    
    private let items: [SettingItem]
    
    init(items: [SettingItem]) {
        self.items = items
    }
    func registerCells(in collectionView: UICollectionView) {
        /// Header
        collectionView.register(UINib(nibName: SettingHeader.identifier, bundle: nil), forSupplementaryViewOfKind: SettingHeader.identifier, withReuseIdentifier: SettingHeader.identifier)
        /// Cell
        collectionView.register(UINib(nibName: LabelAndTextFieldCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: LabelAndTextFieldCollectionViewCell.identifier)
    }
    var numberOfItems: Int {
        items.count
    }
    func cellForItems(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LabelAndTextFieldCollectionViewCell.identifier, for: indexPath) as? LabelAndTextFieldCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let item = items[indexPath.item]
        cell.nameLabel.text = item.name
        return cell
    }
}
// MARK: - Header And Footer
//
extension SettingCollectionViewSection: HeaderAndFooterProvider {
    func cellForItems(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == SettingHeader.identifier,
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: SettingHeader.identifier,
            for: indexPath) as? SettingHeader {
            header.titleLabel.text = "Uploud Image"
            header.imageSetting.image = Images.profilePhoto
            return header
        }
        return UICollectionReusableView()
    }
    
}
// MARK: - Layout
//
struct SettingCollectionLayoutSection: LayoutSectionProvider {
    func layoutSection() -> NSCollectionLayoutSection {
        /// Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        /// Group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(50))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0)
        /// Section
        let section = NSCollectionLayoutSection(group: group)
         /// Header
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(130)),
            elementKind: SettingHeader.identifier,
            alignment: .top)
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
}
