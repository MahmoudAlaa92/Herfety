//
//  WishlistCollectionViewSection.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 10/02/2025.
//

import UIKit


class WishlistCollectionViewSection: CollectionViewProvider {
    
    // MARK: - Properties
    private let whishlistItems: [WishlistItems]
    
    // MARK: - Init
    init(whishlistItems: [WishlistItems]) {
        self.whishlistItems = whishlistItems
    }
    
    /// Register cell
    func registerCells(in collectionView: UICollectionView) {
        collectionView.register(UINib(nibName: WishlistCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: WishlistCollectionViewCell.identifier)
        
        collectionView.register(UINib(nibName: HeaderView.headerIdentifier, bundle: nil), forSupplementaryViewOfKind: "Header", withReuseIdentifier: HeaderView.headerIdentifier)
    }
    var numberOfItems: Int {
        whishlistItems.count
    }
    
    func cellForItems(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WishlistCollectionViewCell.identifier, for: indexPath) as? WishlistCollectionViewCell else {
            return UICollectionViewCell()
        }
        let item = whishlistItems[indexPath.item]
        cell.imageCell.image = item.image
        cell.nameCell.text = item.name
        cell.descriptionCell.text = item.description
        cell.priceCell.text = item.price
        
        return cell
    }
}
// MARK: - Header And Foter for category
//
extension WishlistCollectionViewSection: HeaderAndFooterProvider {
    func cellForItems(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == "Header" {
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HeaderView.headerIdentifier,
                for: indexPath) as! HeaderView
            
            header.configure(title:  "Wishlist", description: "", titleFont:.title1, titleColor: Colors.primaryBlue, shouldShowButton: false)
            return header
        }
        
        return UICollectionReusableView()
    }
}
// MARK: - Layout
//
struct WishlistSectionLayoutProvider: SectionLayoutProvider {
    
    func layoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(120))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
//        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
    
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 0
        section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                      heightDimension: .absolute(50)),
                                                    elementKind: "Header",
                                                    alignment: .top)]
        return section
    }
}
