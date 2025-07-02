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
    private let tabBarController = CustomeTabBarViewController()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
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
        // Present tab bar
        navigationController.setViewControllers([tabBarController], animated: true)
        navigationController.setNavigationBarHidden(true, animated: false)
    }
}
