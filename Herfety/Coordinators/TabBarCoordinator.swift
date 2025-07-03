//
//  TabBarCoordinator.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 01/07/2025.
//

import UIKit

class TabBarCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    let tabBarController = CustomeTabBarViewController()
    
    init() {
        self.navigationController = UINavigationController()
    }
    
    deinit {
        print("deinit \(Self.self)")
    }
    
    func start() {
        
        let homeCoordinator = HomeCoordinator(navigationController: UINavigationController())
        let wishlistCoordinator = WishlistCoordinator(navigationController: UINavigationController())
        let cartCoordinator = CartCoordinator(navigationController: UINavigationController())
        let profileCoordinator = ProfileCoordinator(navigationController: UINavigationController())
        
        childCoordinators = [homeCoordinator, wishlistCoordinator, cartCoordinator, profileCoordinator]
        
        childCoordinators.forEach { $0.start() }
        
        tabBarController.viewControllers = childCoordinators.map {
            $0.navigationController
        }
        // Set tab bar items
        configureTabBarItems()
    }
}
// MARK: - Private Handlers
//
extension TabBarCoordinator {
    private func configureTabBarItems() {
        guard let items = tabBarController.tabBar.items else { return }
        
        let images = [
            (selected: Images.homeSelected, deselected: Images.homeIcon),
            (selected: Images.wishlistSelected, deselected: Images.heartIcon),
            (selected: Images.cartSelected, deselected: Images.cartIcon),
            (selected: Images.profileSelected, deselected: Images.profileIcon)
        ]
        
        for (index, item) in items.enumerated() {
            item.image = images[index].deselected.withRenderingMode(.alwaysOriginal)
            item.selectedImage = images[index].selected.withRenderingMode(.alwaysOriginal)
            item.title = nil
            item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -20, right: 0)
        }
    }
}
