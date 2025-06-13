//
//  ProfileCollectionViewSection.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 05/03/2025.
//

import UIKit

class NameOfProfileCollectionViewSection: CollectionViewDataSource {
    
    var sectionName: Name
    init(sectionName: Name) {
        self.sectionName = sectionName
    }
    func registerCells(in collectionView: UICollectionView) {
        collectionView.register(UINib(nibName: NameCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: NameCollectionViewCell.identifier)
    }
    
    var numberOfItems: Int {
        1
    }
    
    func cellForItems(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NameCollectionViewCell.identifier, for: indexPath) as? NameCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.imageProfile.image = sectionName.image
        cell.nameProfile.text = sectionName.name
        cell.emailProfile.text = sectionName.email
        return cell
    }
}

// MARK: - Layout
//
struct NameCollectionViewLayoutSection: LayoutSectionProvider {
    
    func layoutSection() -> NSCollectionLayoutSection {
    
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                          heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(90))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 20, trailing: 0)
        
        return section
    }
}
