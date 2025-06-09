//
//  ReviewerCollectionViewSection.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 03/03/2025.
//

import UIKit

class ReviewerCollectionViewSection: CollectionViewDataSource {
    
    let reviewers: [Reviewrr]
    var onDelete: ((Int) -> Void)?

    init(reviewers: [Reviewrr]) {
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

        cell.nameReviewer.text = item.user?.userName ?? "No Name"
        if let imageUrl = item.user?.image, !imageUrl.isEmpty {
            cell.imageView.setImage(with: imageUrl, placeholderImage: Images.iconPersonalDetails)
        } else {
            cell.imageView.image = Images.iconPersonalDetails
        }
        cell.commentReviewer.text = item.review
        cell.dateReviewer.text = item.createdAt
        cell.cosmosView.rating = Double(item.rating) ?? 0.0
        return cell
    }
    
}
// MARK: - Delegate
//
extension ReviewerCollectionViewSection: ContextMenuProvider {
    func contextMenuConfiguration(for collectionView: UICollectionView, at indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash"), attributes: .destructive) {  _ in
                self.onDelete?(indexPath.row)
            }
            let update = UIAction(title: "Edit", image: UIImage(systemName: "pencil"), attributes: .destructive) {  _ in
                
            }
            return UIMenu(title: "", children: [delete, update])
        }
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
