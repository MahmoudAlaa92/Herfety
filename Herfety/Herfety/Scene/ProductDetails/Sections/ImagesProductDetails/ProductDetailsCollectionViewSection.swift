//
//  ProductDetailsCollectionViewSection.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 28/02/2025.
//

import UIKit

class ProductDetailsCollectionViewSection: CollectionViewProvider {
    
    let productItems: Product
    
    init(productItems: Product) {
        self.productItems = productItems
    }
    
    func registerCells(in collectionView: UICollectionView) {
        /// Section
        collectionView.register(UINib(nibName: ImagesProductDetailsCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ImagesProductDetailsCollectionViewCell.identifier)
        /// Header
        collectionView.register(UINib(nibName: TitleProductDetails.identifier, bundle: nil), forSupplementaryViewOfKind: TitleProductDetails.identifier, withReuseIdentifier: TitleProductDetails.identifier)
        /// Footer
        collectionView.register(UINib(nibName: DescriptionProductDetails.identifier, bundle: nil), forSupplementaryViewOfKind: DescriptionProductDetails.identifier, withReuseIdentifier: DescriptionProductDetails.identifier)
    }
    
    var numberOfItems: Int {
        return productItems.image.count
    }
    
    func cellForItems(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagesProductDetailsCollectionViewCell.identifier, for: indexPath) as? ImagesProductDetailsCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.imageProduct.image = productItems.image[indexPath.row]
        cell.indexProduct.text = "\(indexPath.row+1)/\(productItems.image.count)"
        return cell
    }
}
// MARK: - Layout
//
struct ProductDetailsCollectionViewProvider: LayoutSectionProvider {
    
    func layoutSection() -> NSCollectionLayoutSection {
        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
        // Header
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(60)),
            elementKind: TitleProductDetails.identifier,
            alignment: .top)
        // Footer
        let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: .init(widthDimension: .fractionalWidth(1),
                              heightDimension: .absolute(120)),
            elementKind: DescriptionProductDetails.identifier,
            alignment: .bottom)
     
        section.boundarySupplementaryItems = [sectionHeader, sectionFooter]
        return section
    }
}
// MARK: - Header And Footer
//
extension ProductDetailsCollectionViewSection: HeaderAndFooterProvider {
    
    func cellForItems(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == TitleProductDetails.identifier,
           let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: TitleProductDetails.identifier,
            for: indexPath) as? TitleProductDetails {
            header.configure(titleLabl: "Elegance Shades", priceLabel: "L.E65,000", avaliableLabel: "Avaliable in stok")
            return header
        }
        else if kind == DescriptionProductDetails.identifier,
                let footer = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: DescriptionProductDetails.identifier,
                    for: indexPath) as? DescriptionProductDetails {
            footer.configure(descriptionLabel: productItems.description)
            return footer
        }
        return UICollectionReusableView()
    }
}
