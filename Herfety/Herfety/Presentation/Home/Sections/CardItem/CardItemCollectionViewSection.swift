//
//  CardItemProvider.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 08/02/2025.
//
import UIKit
import Combine

class CardItemCollectionViewSection: CollectionViewDataSource {
    // MARK: - Properties
    var productItems: [Products]
    var headerConfigurator: ((HeaderView) -> Void)?
    var selectedItem = PassthroughSubject<WishlistItem, Never>()
    
    // MARK: - Init
    init(productItems: [Products]) {
        self.productItems = productItems
    }
    /// RegisterCell
    func registerCells(in collectionView: UICollectionView) {
        collectionView.register(UINib(nibName: CardOfProductCollectionViewCell.cellIdentifier, bundle: nil), forCellWithReuseIdentifier: CardOfProductCollectionViewCell.cellIdentifier)
        
        /// Register for HeaderView
        collectionView.register(UINib(nibName: HeaderView.headerIdentifier, bundle: nil), forSupplementaryViewOfKind: "Header", withReuseIdentifier: HeaderView.headerIdentifier)
    }
    
    var numberOfItems: Int {
        return productItems.count
    }
    
    func cellForItems(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardOfProductCollectionViewCell.cellIdentifier, for: indexPath) as? CardOfProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let item = productItems[indexPath.item]
        
        cell.nameProduct.text = item.name
        cell.priceProduct.text = "$" +  String(format: "%.2f", Double(item.price ?? 0))
        
        var price = item.price ?? 0
        var offer = item.offerPrice ?? 0
        let discount = (Double(offer) / 100.0) * Double(price)
        let finalPrice = Double(price) + discount
        
        cell.offerPrice.text = "$" + String(format: "%.2f", finalPrice)
        
        cell.offerProduct.text = "\(Int(item.offerPrice ?? 0))%\nOFF"
        price = item.price ?? 0
        offer = item.offerPrice ?? 0
        let savedAmount = (Double(offer) / 100.0) * Double(price)
        cell.savePrice.text = "Save $" + String(format: "%.2f", savedAmount)
        cell.imageProduct.setImage(with: item.thumbImage ?? "", placeholderImage: Images.loading)
        
        Task {
            let userId = await DataStore.shared.getUserId()
            
            let itemToAdded = WishlistItem(userID: userId, productID: item.id,vendorId: item.vendorID ,name: item.name, qty: item.qty, price: item.price, offerPrice: item.offerPrice, offerStartDate: item.offerStartDate, offerEndDate: item.offerEndDate, categoryID: item.categoryID, createdAt: item.createdAt, updatedAt: item.updatedAt, isApproved: item.isApproved, longDescription: item.longDescription, shortDescription: item.shortDescription, seoDescription: item.seoDescription, thumbImage: item.thumbImage, productType: item.productType)
            
            await MainActor.run { cell.configureProduct(with: itemToAdded) }
        }
        return cell
    }
}
// MARK: - Delegate
//
extension CardItemCollectionViewSection: CollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = productItems[indexPath.item]
        Task {
            let userId = await DataStore.shared.getUserId()
            
            let wishListItem = WishlistItem(userID: userId, productID: item.id, name: item.name, qty: item.qty, price: item.price, offerPrice: item.offerPrice, offerStartDate: item.offerStartDate, offerEndDate: item.offerEndDate, categoryID: item.categoryID, createdAt: item.createdAt, updatedAt: item.updatedAt, isApproved: item.isApproved, longDescription: item.longDescription, shortDescription: item.shortDescription, seoDescription: item.seoDescription, thumbImage: item.thumbImage, productType: item.productType)
            
            await MainActor.run { selectedItem.send(wishListItem) }
        }
    }
}
// MARK: - Layout
//
struct CardProductSectionLayoutProvider: LayoutSectionProvider {
    
    func layoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(220),
            heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        section.interGroupSpacing = 10
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                                          heightDimension: .absolute(56)), elementKind: "Header", alignment: .top)
        sectionHeader.contentInsets = NSDirectionalEdgeInsets(top: -16, leading: 0, bottom: 0, trailing: 0)
        
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
}
// MARK: - Header And Foter for category
//
extension CardItemCollectionViewSection: HeaderAndFooterProvider {
    
    func cellForItems(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == "Header" {
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HeaderView.headerIdentifier,
                for: indexPath) as! HeaderView
            
            headerConfigurator?(header)
            return header
        }
        
        return UICollectionReusableView()
    }
}
