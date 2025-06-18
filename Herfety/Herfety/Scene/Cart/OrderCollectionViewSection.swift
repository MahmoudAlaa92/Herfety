//
//  OrderCollectionViewSection.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 11/02/2025.
//

import UIKit
import Combine

class OrderCollectionViewSection: CollectionViewDataSource {
    // MARK: - Properties
    let orderItems: [Wishlist]
    let countUpdateSubject = PassthroughSubject<(Int, Int), Never>()
    let deleteItemSubject = PassthroughSubject<Int, Never>()

    // MARK: - Init
    init(orderItems: [Wishlist]) {
        self.orderItems = orderItems
    }
    func registerCells(in collectionView: UICollectionView) {
        collectionView.register(UINib(nibName: OrderCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: OrderCollectionViewCell.identifier)
        
        collectionView.register(UINib(nibName: HeaderView.headerIdentifier, bundle: nil), forSupplementaryViewOfKind: "Header", withReuseIdentifier: HeaderView.headerIdentifier)
    }
    
    var numberOfItems: Int {
        return orderItems.count
    }
    
    func cellForItems(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OrderCollectionViewCell.identifier, for: indexPath) as? OrderCollectionViewCell else {
            return UICollectionViewCell()
        }
        let item = orderItems[indexPath.item]
        
        cell.nameProduct.text = item.name
        cell.descriptionProduct.text = item.shortDescription? .split(separator: " ")
            .prefix(3)
            .joined(separator: " ") ?? ""
           
        cell.imageProduct.setImage(with: item.thumbImage ?? "", placeholderImage: Images.loading)
        cell.numberOfProduct.text = "\(item.qty ?? 1)"
        cell.priceProduct.text = "$" +  String(format: "%.2f", Double(item.price ?? 0.0))
        cell.onChangeCountOrder = { [weak self] newCount in
            self?.countUpdateSubject.send((indexPath.item, newCount))
        }
        
        return cell
    }
}
// MARK: - Delegate
//
extension OrderCollectionViewSection: ContextMenuProvider {
    func contextMenuConfiguration(for collectionView: UICollectionView, at indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash"), attributes: .destructive) {  _ in
              
                self.deleteItemSubject.send(indexPath.item)
            }
            return UIMenu(title: "", children: [delete])
        }
    }
}
// MARK: - Header And Foter for category
//
extension OrderCollectionViewSection: HeaderAndFooterProvider {
    func cellForItems(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == "Header" {
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HeaderView.headerIdentifier,
                for: indexPath) as! HeaderView
            
            header.configure(title:  "My Order", description: "", titleFont:.title1, titleColor: Colors.primaryBlue, shouldShowButton: false)
            return header
        }
        
        return UICollectionReusableView()
    }
}

// MARK: - Layout
//
struct OrderSectionLayoutProvider: LayoutSectionProvider {
    
    func layoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(120))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
    
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 0
        section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                      heightDimension: .absolute(50)),
                                                    elementKind: "Header",
                                                    alignment: .top)]
        return section
    }
}
