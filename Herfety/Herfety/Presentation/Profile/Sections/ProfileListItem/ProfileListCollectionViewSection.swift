//
//  ProfileListCollectionViewSection.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 06/03/2025.
//

import UIKit
import SafariServices

class ProfileListCollectionViewSection: CollectionViewDataSource {
    // MARK: - Properties
    private let items: [ProfileListItem]
    weak var coordinator: PorfileTransionDelegate?
    
    // MARK: - Init
    init(items: [ProfileListItem], coordinator: PorfileTransionDelegate?) {
        self.items = items
        self.coordinator = coordinator
    }
    
    func registerCells(in collectionView: UICollectionView) {
        /// Header
        collectionView.register(UINib(nibName: HeaderView.headerIdentifier, bundle: nil), forSupplementaryViewOfKind: "Header", withReuseIdentifier: HeaderView.headerIdentifier)
        /// Cell
        collectionView.register(UINib(nibName: ProfileListCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ProfileListCollectionViewCell.identifier)
    }
    
    var numberOfItems: Int {
        items.count
    }
    
    func cellForItems(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileListCollectionViewCell.identifier, for: indexPath) as? ProfileListCollectionViewCell else {
            return UICollectionViewCell()
        }
        let item = items[indexPath.item]
        
        cell.imageOfView.image = item.icon
        cell.nameLabel.text = item.title
        cell.languageLabel.text = ""
        
        return cell
    }
}
// MARK: - Delegate
//
extension ProfileListCollectionViewSection: CollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let item = items[indexPath.item]
            
            switch item.title {
            case L10n.Profile.myOrder:
                coordinator?.gotToCartVC()
            case L10n.Profile.myFavourites:
                coordinator?.gotToWishlistVC()
            case L10n.Profile.shippingAddress:
                coordinator?.gotToShippingVC()
            case L10n.Profile.myCard:
                coordinator?.gotToMyCardVC()
            case L10n.Profile.setting:
                coordinator?.gotToSettingVC()
            case L10n.Profile.logout:
                coordinator?.goToAuthVC()
            default:
                break
            }
        } else if indexPath.section == 2 {
            let item = items[indexPath.item]
            switch item.title {
            case L10n.Profile.faqs:
                coordinator?.gotToSafari(url: "http://www.appcoda.com/contact")
            case L10n.Profile.privacyPolicy:
                self.coordinator?.gotToSafari(url: "https://www.appcoda.com/privacy-policy/")
                break
            default:
                break
            }
            
        }
    }
}
// MARK: - Layout
//
struct ProfileListLayoutSection: LayoutSectionProvider {
    
    func layoutSection() -> NSCollectionLayoutSection {
        /// Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(50))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        /// Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(50))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                     subitems: [item])
        /// Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 50, trailing: 15)
        
        section.decorationItems = [.background(elementKind: SectionDecorationView.identifier) ]
        
        return section
    }
}
