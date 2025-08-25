//
//  LogoutButtonCollectionViewSection.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 12/04/2025.
//

import UIKit
import Combine

class LogoutButtonCollectionViewSection: CollectionViewDataSource {
    // MARK: - Properteis
    let onLogoutPressed = PassthroughSubject<Void, Never>()
    
    func registerCells(in collectionView: UICollectionView) {
        /// Cell
        collectionView.register(UINib(nibName: LogoutButttonCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: LogoutButttonCollectionViewCell.identifier)
    }
    
    var numberOfItems: Int { 1 }
    
    func cellForItems(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LogoutButttonCollectionViewCell.identifier, for: indexPath) as? LogoutButttonCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configureButton(title: L10n.Profile.logout, image: Images.logout)
        cell.onLogoutPressed = { [weak self] in
            self?.onLogoutPressed.send()
        }
        return cell
    }
}
// MARK: - Layout
//
struct LogoutButtonCollectionLayoutSection: LayoutSectionProvider {
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
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        /// Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: -20, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }
}
