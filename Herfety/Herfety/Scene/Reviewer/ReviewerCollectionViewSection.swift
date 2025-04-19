//
//  ReviewerCollectionViewSection.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 03/03/2025.
//

import UIKit

class ReviewerCollectionViewSection: CollectionViewDataSource {
    
    let reviewers: [Reviewer]
    
    init(reviewers: [Reviewer]) {
        self.reviewers = reviewers
    }
    func registerCells(in collectionView: UICollectionView) {
        /// Cell
        collectionView.register(UINib(nibName: ReviewersCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ReviewersCollectionViewCell.identifier)
        /// Header
        collectionView.register(UINib(nibName: HeaderView.headerIdentifier, bundle: nil), forSupplementaryViewOfKind: HeaderView.headerIdentifier, withReuseIdentifier: HeaderView.headerIdentifier)
    }
    
    var numberOfItems: Int {
        reviewers.count
    }
    
    func cellForItems(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewersCollectionViewCell.identifier, for: indexPath) as? ReviewersCollectionViewCell else {
            return UICollectionViewCell()
        }
        let item = reviewers[indexPath.row]
        cell.nameReviewer.text = item.name
        cell.imageView.image = item.image
        cell.commentReviewer.text = item.comment
        cell.dateReviewer.text = item.date
        cell.cosmosView.rating = item.rating
        return cell
    }
    
}
// MARK: - Layout
//
struct ReviewerCollectionViewLayoutSection: LayoutSectionProvider {
    
    func layoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(120))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let headerview = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: .init(widthDimension: .fractionalWidth(1),
                              heightDimension: .absolute(30)),
            elementKind: HeaderView.headerIdentifier,
            alignment: .top)
        
        section.boundarySupplementaryItems = [headerview]
        
        return section
    }
}
