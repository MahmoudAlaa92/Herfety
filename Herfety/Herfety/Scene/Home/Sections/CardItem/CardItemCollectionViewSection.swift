//
//  CardItemProvider.swift
//  Herfety/Users/work in/Herfety/Herfety/Herfety/Scene/Home/HomeViewController.swift
//
//  Created by Mahmoud Alaa on 08/02/2025.
//

import UIKit
import Combine

class CardItemCollectionViewSection: CollectionViewProvider {
    // MARK: - Properties
    let productItems: [ProductItem]
    var headerConfigurator: ((HeaderView) -> Void)?
    let selectedItem = PassthroughSubject<ProductItem, Never>()
    
    // MARK: - Init
    init(productItems: [ProductItem]) {
        self.productItems = productItems
    }
    /// RegisterCell
    func registerCells(in collectionView: UICollectionView) {
        collectionView.register(UINib(nibName: CardOfProductCollectionViewCell.cellIdentifier, bundle: nil), forCellWithReuseIdentifier: CardOfProductCollectionViewCell.cellIdentifier)
        
        /// Register for HeaderView
        collectionView.register(UINib(nibName: HeaderView.headerIdentifier, bundle: nil), forSupplementaryViewOfKind: "Header", withReuseIdentifier: HeaderView.headerIdentifier)
    }
    
    var numberOfItems: Int {
        return productItems.count
    }
    
    func cellForItems(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardOfProductCollectionViewCell.cellIdentifier, for: indexPath) as? CardOfProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        let item = productItems[indexPath.item]
        cell.imageProduct.image = item.image
        cell.nameProduct.text = item.name
        cell.offerPrice.text = item.discountPrice
        cell.priceProduct.text = item.price
        cell.offerProduct.text = " \(item.offerPrice)\nOFF"
        cell.savePrice.text = item.savePrice
        return cell
    }
}
// MARK: - Delegate
//
extension CardItemCollectionViewSection: CollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = productItems[indexPath.item]
        selectedItem.send(item)
    }
}
// MARK: - Layout
//
struct CardProductSectionLayoutProvider: LayoutSectionProvider {
    
    func layoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(220),
            heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
        section.interGroupSpacing = 10
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                                          heightDimension: .absolute(56)), elementKind: "Header", alignment: .top)
        sectionHeader.contentInsets = NSDirectionalEdgeInsets(top: 14, leading: 0, bottom: 0, trailing: 0)
        
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
}

// MARK: - Header And Foter for category
//
extension CardItemCollectionViewSection: HeaderAndFooterProvider {
    
    func cellForItems(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == "Header" {
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HeaderView.headerIdentifier,
                for: indexPath) as! HeaderView
            
            headerConfigurator?(header)
            return header
        }
        
        return UICollectionReusableView()
    }
}
