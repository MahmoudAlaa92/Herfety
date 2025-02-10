//
//  TopBrandsProviders.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 09/02/2025.
//

import UIKit

class TopBrandsCollectionViewSection: CollectionViewProvider {
    
    // MARK: - Properties
    let topBrandsItems: [TopBrandsItems]
    
    // MARK: - Init
    init(topBrandsItems: [TopBrandsItems]) {
        self.topBrandsItems = topBrandsItems
    }
    
    /// Register cell
    func registerCells(in collectionView: UICollectionView) {
        collectionView.register(UINib(nibName: TopBrandsCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: TopBrandsCollectionViewCell.identifier)
        
        collectionView.register(UINib(nibName: HeaderView.headerIdentifier, bundle: nil), forSupplementaryViewOfKind: "Header", withReuseIdentifier: HeaderView.headerIdentifier)
    }
    
    var numberOfItems: Int {
        return topBrandsItems.count
    }
    
    func cellForItems(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopBrandsCollectionViewCell.identifier, for: indexPath) as? TopBrandsCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let item = topBrandsItems[indexPath.item]
        cell.nameBrands.text = item.name
        cell.imageOfLogo.image = item.image
        cell.imageOfBrands.image = item.logo
        
        cell.offerBrands.text = item.offer
        return cell
    }
    
}

// MARK: - Layout
//
struct TopBrandsSectionLayoutProvider: SectionLayoutProvider {
    
    func layoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7),
                                               heightDimension: .absolute(150))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5)
        section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                      heightDimension: .absolute(30)),
                                                                      elementKind: "Header",
                                                                      alignment: .top)]
        return section
    }
    
}

// MARK: - Header And Foter for category
//
extension TopBrandsCollectionViewSection: HeaderAndFooterProvider {
    
    func cellForItems(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == "Header" {
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HeaderView.headerIdentifier,
                for: indexPath) as! HeaderView
            
            header.configure(title: "Top ", description: "Brands", shouldShowButton: false)
            return header
        }
        
        return UICollectionReusableView()
    }
}
