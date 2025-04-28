//
//  ReviewCollectionViewSection.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 01/03/2025.
//

import UIKit

class ReviewCollectionViewSection: CollectionViewDataSource {
    
    let reviewItems: [Review]
    let product: Products
    init(reviewItems: [Review], rating: Products) {
        self.reviewItems = reviewItems
        self.product = rating
    }
    
    func registerCells(in collectionView: UICollectionView) {
        /// Cell
        collectionView.register(UINib(nibName: ReviewCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ReviewCollectionViewCell.identifier)
        /// Header
        collectionView.register(UINib(nibName: TitleReviewsCollectionReusableView.identifier, bundle: nil), forSupplementaryViewOfKind: TitleReviewsCollectionReusableView.identifier, withReuseIdentifier: TitleReviewsCollectionReusableView.identifier)
        /// Footer
        collectionView.register(UINib(nibName: ButtonCollectionReusableView.identifier, bundle: nil), forSupplementaryViewOfKind: ButtonCollectionReusableView.identifier, withReuseIdentifier: ButtonCollectionReusableView.identifier)
    }
    
    var numberOfItems: Int {
        return reviewItems.count
    }
    
    func cellForItems(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewCollectionViewCell.identifier, for: indexPath) as? ReviewCollectionViewCell else {
            return UICollectionViewCell()
        }
        let item = reviewItems[indexPath.row]
        cell.commentReviewer.text = item.comment
        cell.imageReviewer.image = item.image
        return cell
    }
}

// MARK: - Layout
//
struct ReviewCollectionViewSectionLayout: LayoutSectionProvider {
    
    func layoutSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(60))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: .init(widthDimension: .fractionalWidth(1),
                              heightDimension: .absolute(60)),
            elementKind: TitleReviewsCollectionReusableView.identifier,
            alignment: .top)
        sectionHeader.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 0, bottom: 8, trailing: 0)
        let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: .init(widthDimension: .fractionalWidth(1),
                              heightDimension: .absolute(60)),
            elementKind: ButtonCollectionReusableView.identifier,
            alignment: .bottom)
        sectionFooter.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0)
        section.boundarySupplementaryItems = [sectionHeader, sectionFooter]
        
        return section
    }
}

// MARK: - Header And Footer
//
extension ReviewCollectionViewSection: HeaderAndFooterProvider {
    func cellForItems(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == TitleReviewsCollectionReusableView.identifier,
           let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: TitleReviewsCollectionReusableView.identifier,
            withReuseIdentifier: TitleReviewsCollectionReusableView.identifier,
            for: indexPath) as? TitleReviewsCollectionReusableView {
            // TODO: change the defualt rating here
            header.configure(numberOfReviews: reviewItems.count, rating: 3.5)
            return header
        } else if kind == ButtonCollectionReusableView.identifier,
                  let footer = collectionView.dequeueReusableSupplementaryView(
                    ofKind: ButtonCollectionReusableView.identifier,
                    withReuseIdentifier: ButtonCollectionReusableView.identifier,
                    for: indexPath) as? ButtonCollectionReusableView {
            footer.configure(with: .init(title: "Add To Cart", target: self, action: #selector(addToCart)))
            return footer
        }
        return UICollectionReusableView()
    }
    ///
    @objc private func addToCart() {
        // add to cart pressed
    }
}
