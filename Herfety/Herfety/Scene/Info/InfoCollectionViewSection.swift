//
//  ShippingCollectionViewSection.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 13/02/2025.
//

import UIKit

class InfoCollectionViewSection: CollectionViewProvider {
    
    let shippingItems: [InfoModel]
    
    init(shippingItems: [InfoModel]) {
        self.shippingItems = shippingItems
    }
    
    func registerCells(in collectionView: UICollectionView) {
        collectionView.register(UINib(nibName: InfoShippingCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: InfoShippingCollectionViewCell.identifier)
    }
    
    var numberOfItems: Int {
        return shippingItems.count
    }
    
    func cellForItems(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InfoShippingCollectionViewCell.identifier, for: indexPath) as? InfoShippingCollectionViewCell else {
            return UICollectionViewCell()
        }
        let item = shippingItems[indexPath.item]
        
        cell.imageView.image = Images.iconLocation
        cell.nameOfPerson.text = item.name
        cell.addressOfPerson.text = item.address
        cell.phoneOfPerson.text = item.phone
        return cell
    }
}


// MARK: - Layout
//
struct ShippingInfoSectionLayoutProvider: SectionLayoutProvider {
    
    func layoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
    
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 0
      
        return section
    }
}
