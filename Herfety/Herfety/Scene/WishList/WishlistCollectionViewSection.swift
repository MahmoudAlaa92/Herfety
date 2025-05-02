//
//  WishlistCollectionViewSection.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 10/02/2025.
//
import UIKit

class WishlistCollectionViewSection: CollectionViewDataSource {
    
    // MARK: - Properties
    private var whishlistItems: [Wishlist]
    
    // MARK: - Init
    init(whishlistItems: [Wishlist]) {
        self.whishlistItems = whishlistItems
    }
    
    /// Register cell
    func registerCells(in collectionView: UICollectionView) {
        collectionView.register(UINib(nibName: WishlistCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: WishlistCollectionViewCell.identifier)
        
        collectionView.register(UINib(nibName: HeaderView.headerIdentifier, bundle: nil), forSupplementaryViewOfKind: "Header", withReuseIdentifier: HeaderView.headerIdentifier)
    }
    var numberOfItems: Int {
        whishlistItems.count
    }
    
    func cellForItems(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WishlistCollectionViewCell.identifier, for: indexPath) as? WishlistCollectionViewCell else {
            return UICollectionViewCell()
        }
        let item = whishlistItems[indexPath.item]
        
        cell.nameCell.text = item.name
        cell.imageCell.setImage(with: item.thumbImage ?? "", placeholderImage: Images.loading)
        cell.descriptionCell.text = item.shortDescription
        cell.priceCell.text = "$" +  String(format: "%.2f", Double(item.price ?? 0.0))
        
        cell.configureOrder(with: item)

        return cell
    }
}
// MARK: - Header And Foter for category
//
extension WishlistCollectionViewSection: HeaderAndFooterProvider {
    func cellForItems(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == "Header" {
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HeaderView.headerIdentifier,
                for: indexPath) as! HeaderView
            
            header.configure(title:  "Wishlist", description: "", titleFont:.title1, titleColor: Colors.primaryBlue, shouldShowButton: false)
            return header
        }
        return UICollectionReusableView()
    }
    
}
// MARK: - Delegate
//
extension WishlistCollectionViewSection: ContextMenuProvider {
    func contextMenuConfiguration(for collectionView: UICollectionView, at indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash"), attributes: .destructive) {  _ in
                let items = CustomeTabBarViewModel.shared
                let wishlist = items.Wishlist[indexPath.row]
                let userId = items.userId ?? 1
                CustomeTabBarViewModel.shared.deleteWishlistItem(userId: userId, productId: (wishlist.productID ?? 1), indexPath: indexPath)
                
            }
            return UIMenu(title: "", children: [delete])
        }
    }
}
// MARK: - Layout
//
struct WishlistSectionLayoutProvider: LayoutSectionProvider {
    
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
