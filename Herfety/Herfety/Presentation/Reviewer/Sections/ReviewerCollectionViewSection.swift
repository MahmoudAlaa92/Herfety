//
//  ReviewerCollectionViewSection.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 03/03/2025.
//

import UIKit
import ViewAnimator

class ReviewerCollectionViewSection: CollectionViewDataSource {
    // MARK: - Properties
    let reviewers: [ReviewrItem]
    var onDelete: ((Int) -> Void)?
    var onUpdate: ((Int, String) -> Void)?
    
    // MARK: - Init
    init(reviewers: [ReviewrItem]) {
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
        cell.nameReviewer.text = item.userName
        if let imageUrl = item.user?.image, !imageUrl.isEmpty {
            cell.imageView.setImage(with: imageUrl, placeholderImage: Images.iconPersonalDetails)
        } else {
            cell.imageView.image = Images.profilePhoto
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
            let delete = UIAction(title: L10n.General.delete, image: UIImage(systemName: "trash"), attributes: .destructive) {  _ in
                self.onDelete?(indexPath.row)
            }
            let update = UIAction(title: L10n.General.edit, image: UIImage(systemName: "pencil"), attributes: .destructive) {  _ in
                let currentReview = self.reviewers[indexPath.row]
                   
                let alert = UIAlertController(title: L10n.Reviews.Edit.title, message: L10n.Reviews.Edit.message, preferredStyle: .alert)
                   alert.addTextField { textField in
                       textField.text = currentReview.review
                   }
                alert.addAction(UIAlertAction(title: L10n.General.cancel, style: .cancel, handler: nil))
                alert.addAction(UIAlertAction(title: L10n.General.update, style: .default) { _ in
                       if let updatedText = alert.textFields?.first?.text, !updatedText.isEmpty {
                           self.onUpdate?(indexPath.row, updatedText)
                       }
                   })
                
                if let windowScene = UIApplication.shared.connectedScenes
                    .compactMap({ $0 as? UIWindowScene })
                    .first(where: { $0.activationState == .foregroundActive }),
                   let topVC = windowScene.windows.first(where: { $0.isKeyWindow })?.rootViewController {
                    topVC.present(alert, animated: true)
                }
            }
            return UIMenu(title: "", children: [delete, update])
        }
    }
}
// MARK: - Header And Footer
//
extension ReviewerCollectionViewSection: HeaderAndFooterProvider {
    
    func cellForItems(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == HeaderView.headerIdentifier,
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: HeaderView.headerIdentifier,
                withReuseIdentifier: HeaderView.headerIdentifier,
                for: indexPath
            ) as? HeaderView
        {
            header.configure(
                title: L10n.Reviews.clientTitle,
                description: "",
                titleFont: .title3,
                shouldShowButton: false
            )
            return header
        }
        return UICollectionReusableView()
    }
}
// MARK: - Animation
//
extension ReviewerCollectionViewSection: SectionAnimationProvider {
    func animationForSection() -> AnimationType {
        return .from(direction: .bottom, offset: 40)
    }
    
    func animationDuration() -> TimeInterval {
        return 0.6
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
