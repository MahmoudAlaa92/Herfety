//
//  ProductsCollectionViewSection.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 22/02/2025.
//

import UIKit
import Combine

class ProductsCollectionViewSection: CollectionViewDataSource {
    // MARK: - Properties
    let Products: [ProductItem]
    let selectedItem = PassthroughSubject<ProductItem, Never>()
    
    // MARK: - Init
    init(Products: [ProductItem]) {
        self.Products = Products
    }
    func registerCells(in collectionView: UICollectionView) {
        collectionView.register(UINib(nibName: CardOfProductCollectionViewCell.cellIdentifier, bundle: nil), forCellWithReuseIdentifier: CardOfProductCollectionViewCell.cellIdentifier)
    }
    var numberOfItems: Int {
        return Products.count
    }
    func cellForItems(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardOfProductCollectionViewCell.cellIdentifier, for: indexPath) as? CardOfProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        let item = Products[indexPath.item]
        cell.nameProduct.text = item.name
        cell.imageProduct.image = item.image
        cell.offerProduct.text = "\(item.offerPrice)\nOFF"
        cell.offerPrice.text = item.discountPrice
        cell.priceProduct.text = item.price
        cell.savePrice.text = item.savePrice
        #warning("Handle Dry principle here")
        let wishlistItem =  WishlistItem(name: item.name, description: "New Item", price: item.price, image: item.image)
        cell.configureProduct(with: wishlistItem)
        let orderItem = OrderModel(name: item.name, description: "New Item", price: Double(item.price.dropFirst()) ?? 0.00 , image: item.image, numberOfOrders: 1)
        cell.configureOrder(with: orderItem)
        return cell
    }
}
// MARK: - Delegate
//
extension ProductsCollectionViewSection: CollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedItem.send(Products[indexPath.item])
    }
}
// MARK: - Layout
//
struct ProductsCollectionViewSectionLayout: LayoutSectionProvider {
    func layoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                          heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let section = NSCollectionLayoutSection(group: group)

        return section
    }
}
