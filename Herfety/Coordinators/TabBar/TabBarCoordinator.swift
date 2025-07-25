//
//  TabBarCoordinator.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 01/07/2025.
//

import UIKit

protocol TabBarTransitionDelegate: AnyObject {
    func goToAuthVC()
}

class TabBarCoordinator: Coordinator {
    
    weak var parentCoordinator: AppTransitionDelegate?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    let tabBarController = CustomeTabBarViewController()
    private var alertPresenter: AlertPresenter

    init(alertPresenter: AlertPresenter) {
        self.navigationController = UINavigationController()
        self.alertPresenter = alertPresenter
    }
    
    deinit {
        print("deinit \(Self.self)")
    }
    
    func start() {
        let homeNav = UINavigationController()
        let wishlistNav = UINavigationController()
        let cartNav = UINavigationController()
        let profileNav = UINavigationController()
        
        let homeCoordinator = HomeCoordinator(navigationController: homeNav,
                                              alertPresenter: AlertCoordinator(presentingViewController: homeNav))
        let wishlistCoordinator = WishlistCoordinator(navigationController: wishlistNav,
                                                      alertPresenter: AlertCoordinator(presentingViewController: wishlistNav))
        let cartCoordinator = CartCoordinator(navigationController: cartNav,
                                              alertPresenter: AlertCoordinator(presentingViewController: cartNav))
        let profileCoordinator = ProfileCoordinator(navigationController: profileNav,
                                                    alertPresenter: AlertCoordinator(presentingViewController: profileNav))
        
        profileCoordinator.parentCoordinator = self
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
// MARK: - Transition Delegate
//
extension TabBarCoordinator: TabBarTransitionDelegate {
    func goToAuthVC() {
        parentCoordinator?.didRequestLogout()
    }
}
