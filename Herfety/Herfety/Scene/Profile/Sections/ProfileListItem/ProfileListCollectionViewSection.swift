//
//  ProfileListCollectionViewSection.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 06/03/2025.
//

import UIKit
import SafariServices

class ProfileListCollectionViewSection: CollectionViewDataSource {
    
    private let items: [ProfileListItem]
    weak var navController: UINavigationController?
    
    init(items: [ProfileListItem], navContoller: UINavigationController?) {
        self.items = items
        self.navController = navContoller
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
        // TODO: Change navigation with coordinator
        if indexPath.section == 1 {
            let item = items[indexPath.item]
            
            switch item.title {
            case "My Order":
                let vc = OrderViewController()
                self.navController?.pushViewController(vc, animated: true)
                break
            case "My Favourites":
                let vc = WishListViewController()
                self.navController?.pushViewController(vc, animated: true)
                break
            case "Shipping Address":
                let vc = InfoViewController()
                self.navController?.pushViewController(vc, animated: true)
                break
            case "My Card":
                let vc = MyCheckoutViewController()
                self.navController?.pushViewController(vc, animated: true)
                break
            case "Logout":
                if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let sceneDelegate = scene.delegate as? SceneDelegate,
                   let window = sceneDelegate.window {
                    
                    let splashVC = SplashViewController(viewModel: SplashViewModel())
                    let navController = UINavigationController(rootViewController: splashVC)
                    
                    // Optional: transition animation
                    UIView.transition(with: window, duration: 0.5) {
                        window.rootViewController = navController
                    }
                }
                break
            case "Hefety Model":
                let safariVC = SFSafariViewController(url: URL(string: "https://www.appcoda.com/privacy-policy/")!)
                safariVC.modalPresentationStyle = .pageSheet
                navController?.present(safariVC, animated: true)
                //            case "Settings":
                // TODO: change this after finle project
                //                let vc = SettingViewController(settingViewModel: SettingViewModel())
                //                self.navController?.pushViewController(vc, animated: true)
                //                break
            default:
                break
            }
        } else if indexPath.section == 2 {
            let item = items[indexPath.item]
            switch item.title {
            case "FAQs":
                let safariVC = SFSafariViewController(url: URL(string: "http://www.appcoda.com/contact")!)
                safariVC.modalPresentationStyle = .pageSheet
                navController?.present(safariVC, animated: true)
            case "Privacy Policy":
                let safariVC = SFSafariViewController(url: URL(string: "https://www.appcoda.com/privacy-policy/")!)
                safariVC.modalPresentationStyle = .pageSheet
                navController?.present(safariVC, animated: true)
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
                                                   heightDimension: .estimated(50)) // or .absolute if fixed
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                         subitems: [item])
            /// Section
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 50, trailing: 15)
            
            section.decorationItems = [.background(elementKind: SectionDecorationView.identifier) ]
            
            return section
        }
    }
