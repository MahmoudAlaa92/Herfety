//
//  WishlistCollectionViewSection.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 10/02/2025.
//
import UIKit
import ViewAnimator
import Combine

class WishlistCollectionViewSection: CollectionViewDataSource {
    
    // MARK: - Properties
    private var whishlistItems: [WishlistItem]
    let deleteItemSubject = PassthroughSubject<WishlistItem, Never>()

    // MARK: - Init
    init(whishlistItems: [WishlistItem]) {
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
        cell.priceCell.text = String(format: NSLocalizedString("products.currency", comment: ""), String(format: "%.2f", Double(item.price ?? 0)))
        
        cell.configureOrder(with: item)
        
        return cell
    }
}
// MARK: - Header And Footer for category
//
extension WishlistCollectionViewSection: HeaderAndFooterProvider {
    func cellForItems(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == "Header" {
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HeaderView.headerIdentifier,
                for: indexPath) as! HeaderView
            
            header.configure(title: NSLocalizedString("wishlist.title", comment: "Wishlist title"), description: "", titleFont:.title1, titleColor: Colors.primaryBlue, shouldShowButton: false)
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
            let delete = UIAction(title: L10n.General.delete, image: UIImage(systemName: "trash"), attributes: .destructive) { [weak self] _ in
                guard let self = self else { return }
                Task { @MainActor in
                    await self.handleWishlistDeletion(at: indexPath)
                }
            }
            return UIMenu(title: "", children: [delete])
        }
    }
    @MainActor
    private func handleWishlistDeletion(at indexPath: IndexPath) async {
        
        let store = DataStore.shared
        
        /// Validate index bounds
        guard indexPath.row < whishlistItems.count else {
            print("❌ Invalid index path for wishlist deletion")
            return
        }
        
        /// Safe access to wishlist items
        let wishlistItem = whishlistItems[indexPath.row]
        guard let productId = wishlistItem.productID else {
            print("❌ Wishlist item missing product ID")
            return
        }
        
        deleteItemSubject.send(wishlistItem)
        
        let userId = await store.getUserId()
        
        /// Perform deletion with proper error handling
        await store.deleteWishlistItem(userId: userId,
                                       productId: productId,
                                       indexPath: indexPath)
    }
}
// MARK: - Animation
//
extension WishlistCollectionViewSection: SectionAnimationProvider {
    func animationForSection() -> AnimationType {
        return .from(direction: .bottom, offset: 40)
    }
    
    func animationDuration() -> TimeInterval {
        return 0.6
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
