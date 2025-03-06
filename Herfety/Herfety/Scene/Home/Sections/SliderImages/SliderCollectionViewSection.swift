//
//  File.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 04/02/2025.
//

import UIKit

class SliderCollectionViewSection: CollectionViewProvider {
    
    private let sliderItems: [SliderItem]
    
    init(sliderItems: [SliderItem]) {
        self.sliderItems = sliderItems
    }
    
    func registerCells(in collectionView: UICollectionView) {
        collectionView.register(UINib(nibName: "SliderImagesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: SliderImagesCollectionViewCell.cellIdentifier)
    }
    
    var numberOfItems: Int {
        return sliderItems.count
    }
    
    func cellForItems(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SliderImagesCollectionViewCell.cellIdentifier, for: indexPath) as? SliderImagesCollectionViewCell else { return UICollectionViewCell() }
        let item = sliderItems[indexPath.item]
        cell.topLabel.text = item.description
        cell.middleLabel.text = item.name
        cell.bottomLabel.text = item.offer
        cell.rightImage.image = item.image
        return cell
    }
}
// MARK: - Layout
//
struct SliderSectionLayoutProvider: LayoutSectionProvider {
    func layoutSection() -> NSCollectionLayoutSection {
           let itemSize = NSCollectionLayoutSize(
               widthDimension: .fractionalWidth(1),
               heightDimension: .fractionalHeight(1))
           let item = NSCollectionLayoutItem(layoutSize: itemSize)
           
           let groupSize = NSCollectionLayoutSize(
               widthDimension: .fractionalWidth(1),
               heightDimension: .absolute(150))
           let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
           group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0
                , bottom: 0, trailing: 0)
           
           let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
           section.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 0, bottom: 10, trailing: 0)
           
           return section
       }
}
