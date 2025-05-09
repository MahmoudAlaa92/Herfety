//
//  DailyEssentailProvider.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 09/02/2025.
//

import UIKit
import Combine

class DailyEssentailCollectionViewSection: CollectionViewDataSource {
    
    // MARK: - Properties
    let dailyEssentail: [DailyEssentialyItem]
    let selectedItem: PassthroughSubject<(DailyEssentialyItem, Int), Never> = .init()
    // MARK: - Init
    init(dailyEssentail: [DailyEssentialyItem]) {
        self.dailyEssentail = dailyEssentail
    }
    
    /// Register cell
    func registerCells(in collectionView: UICollectionView) {
        collectionView.register(UINib(nibName: DailyEssentailCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DailyEssentailCollectionViewCell.identifier)
        
        collectionView.register(UINib(nibName: HeaderView.headerIdentifier, bundle: nil), forSupplementaryViewOfKind: "Header", withReuseIdentifier: HeaderView.headerIdentifier)
    }
    
    var numberOfItems: Int {
        return dailyEssentail.count
    }
    
    func cellForItems(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyEssentailCollectionViewCell.identifier, for: indexPath) as? DailyEssentailCollectionViewCell else {
            return UICollectionViewCell()
        }
        let item = dailyEssentail[indexPath.item]
        cell.imageCell.image = item.image
        cell.nameOfCell.text = item.name
        cell.offerCell.text = item.offer
        
        return cell
    }
    
}
// MARK: - Header And Foter for category
//
extension DailyEssentailCollectionViewSection: HeaderAndFooterProvider {
    
    func cellForItems(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == "Header" {
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HeaderView.headerIdentifier,
                for: indexPath) as! HeaderView
            
            header.configure(title: "Daily ", description: "Essential", shouldShowButton: false)
            return header
        }
        
        return UICollectionReusableView()
    }
}
// MARK: - Delegate
//
extension DailyEssentailCollectionViewSection: CollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = dailyEssentail[indexPath.item]
        selectedItem.send((item, indexPath.row))
    }
}
// MARK: - Layout
//
struct DailyEssentailSectionLayoutProvider: LayoutSectionProvider {
    
    func layoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(130),
                                               heightDimension: .absolute(130))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.orthogonalScrollingBehavior = .groupPaging
        section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                      heightDimension: .absolute(30)),
                                                                      elementKind: "Header",
                                                                      alignment: .top) ]
        return section
    }
    
}
