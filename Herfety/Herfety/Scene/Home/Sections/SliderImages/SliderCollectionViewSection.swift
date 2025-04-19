//
//  File.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 04/02/2025.
//
import UIKit
import Combine

class SliderCollectionViewSection: CollectionViewDataSource {
    // MARK: - Properties
    private let sliderItems: [SliderItem]
    let selectedItem = PassthroughSubject<SliderItem, Never>()
    // MARK: - Init
    init(sliderItems: [SliderItem]) {
        self.sliderItems = sliderItems
    }
    func registerCells(in collectionView: UICollectionView) {
        /// Cell
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
// MARK: - Delegate
//
extension SliderCollectionViewSection: CollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedItem.send(sliderItems[indexPath.item])
    }
}
// MARK: - Layout
//
struct SliderSectionLayoutProvider: LayoutSectionProvider {
    func layoutSection() -> NSCollectionLayoutSection {
        /// Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        /// Group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(150))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        /// Section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 0, bottom: 10, trailing: 0)
        
        return section
    }
}
