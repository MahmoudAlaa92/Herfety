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
    var Products: [Products]
    let selectedItem = PassthroughSubject<WishlistItem, Never>()
    
    // MARK: - Init
    init(Products: [Products]) {
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
        // TODO: Handle DRY Principle for this part
        let item = Products[indexPath.item]
        cell.nameProduct.text = item.name
        cell.priceProduct.text = String(format: NSLocalizedString("products.currency", comment: ""), String(format: "%.2f", Double(item.price ?? 0)))
        
        var price = item.price ?? 0
        var offer = item.offerPrice ?? 0
        let discount = (Double(offer) / 100.0) * Double(price)
        let finalPrice = Double(price) + discount
        
        cell.offerPrice.text = String(format: NSLocalizedString("products.currency", comment: ""), String(format: "%.2f", finalPrice))

        cell.offerProduct.text = String(format: NSLocalizedString("products.discountFormat", comment: ""), String(Int(item.offerPrice ?? 0)))
        price = item.price ?? 0
        offer = item.offerPrice ?? 0
        let savedAmount = (Double(offer) / 100.0) * Double(price)
        cell.savePrice.text = String(format: NSLocalizedString("products.saveFormat", comment: ""), String(format: "%.2f", savedAmount))
        cell.imageProduct.setImage(with: item.thumbImage ?? "", placeholderImage: Images.loading)
        
        Task {
            let userId = await DataStore.shared.getUserId()
            
            let itemToAdded = WishlistItem(userID: userId, productID: item.id, name: item.name, qty: item.qty, price: item.price, offerPrice: item.offerPrice, offerStartDate: item.offerStartDate, offerEndDate: item.offerEndDate, categoryID: item.categoryID, createdAt: item.createdAt, updatedAt: item.updatedAt, isApproved: item.isApproved, longDescription: item.longDescription, shortDescription: item.shortDescription, seoDescription: item.seoDescription, thumbImage: item.thumbImage, productType: item.productType)
            
            await MainActor.run { cell.configureProduct(with: itemToAdded) }
        }
        return cell
    }
}
// MARK: - Delegate
//
extension ProductsCollectionViewSection: CollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = Products[indexPath.item]
        
        Task {
            let userId = await DataStore.shared.getUserId()
            
            let wishListItem = WishlistItem(userID: userId, productID: item.id, name: item.name, qty: item.qty, price: item.price, offerPrice: item.offerPrice, offerStartDate: item.offerStartDate, offerEndDate: item.offerEndDate, categoryID: item.categoryID, createdAt: item.createdAt, updatedAt: item.updatedAt, isApproved: item.isApproved, longDescription: item.longDescription, shortDescription: item.shortDescription, seoDescription: item.seoDescription, thumbImage: item.thumbImage, productType: item.productType)
            
            await MainActor.run { selectedItem.send(wishListItem) }
        }
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
                                               heightDimension: .absolute(220))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let section = NSCollectionLayoutSection(group: group)

        return section
    }
}
