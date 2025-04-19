//
//  ProfileListCollectionViewSection.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 06/03/2025.
//

import UIKit

class ProfileListCollectionViewSection: CollectionViewDataSource {
    
    private let items: [ProfileListItem]
    init(items: [ProfileListItem]) {
        self.items = items
    }
    
    func registerCells(in collectionView: UICollectionView) {
        /// Header
        collectionView.register(UINib(nibName: HeaderView.headerIdentifier, bundle: nil), forSupplementaryViewOfKind: "Header", withReuseIdentifier: HeaderView.headerIdentifier)
        /// Cell
        collectionView.register(UINib(nibName: ProfileListCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ProfileListCollectionViewCell.identifier)
    }
    
    var numberOfItems: Int {
        items.count
    }
    
    func cellForItems(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileListCollectionViewCell.identifier, for: indexPath) as? ProfileListCollectionViewCell else {
            return UICollectionViewCell()
        }
        let item = items[indexPath.item]
        
        cell.imageOfView.image = item.icon
        cell.nameLabel.text = item.title
        cell.languageLabel.text = ""
        return cell
    }
}
// MARK: - Layout
//
struct ProfileListLayoutSection: LayoutSectionProvider {

    func layoutSection() -> NSCollectionLayoutSection {
        /// Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(50))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        /// Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(50)) // or .absolute if fixed
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                     subitems: [item])
        /// Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 50, trailing: 15)
        
        section.decorationItems = [.background(elementKind: SectionDecorationView.identifier) ]

        return section
    }
}
