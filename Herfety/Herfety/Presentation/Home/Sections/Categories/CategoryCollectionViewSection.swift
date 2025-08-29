//
//  CategoryProvider.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 07/02/2025.
//

import UIKit
import Combine
import ViewAnimator

class CategoryCollectionViewSection: CollectionViewDataSource {
    
    // MARK: - Properties
    var categoryItems: [CategoryElement]
    let categorySelection = PassthroughSubject<CategoryElement, Never>()
    
    // MARK: - Init
    init(categoryItems: [CategoryElement]) {
        self.categoryItems = categoryItems
    }
    /// Register cell
    func registerCells(in collectionView: UICollectionView) {
        collectionView.register(UINib(nibName: "CategoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: CategoriesCollectionViewCell.cellIdentifier)
        
        /// Register for HeaderView
        collectionView.register(
              UINib(nibName: "HeaderView", bundle: nil),
              forSupplementaryViewOfKind: "Header",
              withReuseIdentifier: HeaderView.headerIdentifier)
    }
    /// Number of items
    var numberOfItems: Int {
        categoryItems.count
    }
    /// Provide items
    func cellForItems(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.cellIdentifier, for: indexPath) as? CategoriesCollectionViewCell  else {
            return UICollectionViewCell()
        }
        
        let item = categoryItems[indexPath.item]
        cell.nameOfCategory.text = item.name
        if let imageUrl = item.icon {
            cell.imageOfCategory.setImage(with: imageUrl, placeholderImage: Images.loading)
        } else{
            cell.imageOfCategory.image = Images.loading
        }

        return cell
    }
}

// MARK: - Header And Foter for category
//
extension CategoryCollectionViewSection: HeaderAndFooterProvider {
    func cellForItems(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == "Header" {
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HeaderView.headerIdentifier,
                for: indexPath) as! HeaderView
            
            header.configure(title:  L10n.Categories.title, description: "", shouldShowButton: true)
            return header
        }
        
        return UICollectionReusableView()
    }
}
// MARK: - Delegate
//
extension CategoryCollectionViewSection: CollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedItems = categoryItems[indexPath.item]
        categorySelection.send(selectedItems)
    }
}
// MARK: - Animation
//
extension CategoryCollectionViewSection: SectionAnimationProvider {
    func animationForSection() -> AnimationType {
        return .from(direction: .bottom, offset: 40)
    }
    
    func animationDuration() -> TimeInterval {
        return 0.6
    }
}
// MARK: - Layout
//
struct CategoriesSectionLayoutSection: LayoutSectionProvider {
    func layoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(90),
            heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0)
        
        section.boundarySupplementaryItems = [
        .init(layoutSize: .init(widthDimension: .
                                fractionalWidth(1),
                                heightDimension: .absolute(30)),
                                elementKind: "Header",
                                alignment: .top)]
        
        return section
    }
}
