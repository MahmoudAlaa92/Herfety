//
//  InfoCollectionViewSection.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 13/02/2025.
//
import UIKit
import Combine
import ViewAnimator

class InfoCollectionViewSection: CollectionViewDataSource {
    
    let infoItems: [InfoModel]
    let deleteItemSubject = PassthroughSubject<Int, Never>()
    init(infoItems: [InfoModel]) {
        self.infoItems = infoItems
    }
    
    func registerCells(in collectionView: UICollectionView) {
        collectionView.register(UINib(nibName: InfoShippingCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: InfoShippingCollectionViewCell.identifier)
    }
    
    var numberOfItems: Int {
        return infoItems.count
    }
    
    func cellForItems(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InfoShippingCollectionViewCell.identifier, for: indexPath) as? InfoShippingCollectionViewCell else {
            return UICollectionViewCell()
        }
        let item = infoItems[indexPath.item]
        
        cell.imageView.image = Images.iconLocation
        cell.nameOfPerson.text = item.name
        cell.addressOfPerson.text = item.address
        cell.phoneOfPerson.text = item.phone
        return cell
    }
}
// MARK: - Delegate
//
extension InfoCollectionViewSection: ContextMenuProvider {
    func contextMenuConfiguration(for collectionView: UICollectionView, at indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            let delete = UIAction(title: L10n.General.delete, image: UIImage(systemName: "trash"), attributes: .destructive) { _ in
                self.deleteItemSubject.send(indexPath.item)
            }
            return UIMenu(title: "", children: [delete])
        }
    }
}
// MARK: - Animation
//
extension InfoCollectionViewSection: SectionAnimationProvider {
    func animationForSection() -> AnimationType {
        return .from(direction: .bottom, offset: 40)
    }
    
    func animationDuration() -> TimeInterval {
        return 0.6
    }
}
// MARK: - Layout
//
struct InfoSectionLayoutProvider: LayoutSectionProvider {
    
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
