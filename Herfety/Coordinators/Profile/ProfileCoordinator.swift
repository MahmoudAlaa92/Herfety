//
//  ProfileCoordinator.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 01/07/2025.
//

import UIKit

protocol PorfileTransionDelegate: AnyObject {
    func gotToCartVC()
    func gotToWishlistVC()
}

protocol ProfileChildDelegate: AnyObject {
    func backToProfile(_ coordinator: Coordinator)
}

class ProfileCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    let alertPresenter: AlertPresenter
    
    init(navigationController: UINavigationController, alertPresenter: AlertPresenter) {
        self.navigationController = navigationController
        self.alertPresenter = alertPresenter
    }
    
    deinit {
        print("deinit \(Self.self)")
    }
    
    func start() {
        let profileVC = ProfileViewController(
            nameViewModel: NameViewModel(),
            profileListViewModel: ProfileListViewModel()
        )
        profileVC.coordinator = self
        navigationController.pushViewController(profileVC, animated: true)
    }
}
// MARK: - Transtion Delegate
//
extension ProfileCoordinator: PorfileTransionDelegate {
    func gotToCartVC() {
        let coordinator = CartCoordinator(navigationController: navigationController, alertPresenter: alertPresenter)
        childCoordinators.append(coordinator)
        coordinator.parentCoordinator = self
        coordinator.start()
    }
    
    func gotToWishlistVC() {
        let coordinator = WishlistCoordinator(navigationController: navigationController, alertPresenter: alertPresenter)
        childCoordinators.append(coordinator)
        coordinator.parentCoordinator = self
        coordinator.start()
    }
}
// MARK: - Transtion Delegate
//
extension ProfileCoordinator: ProfileChildDelegate {
    
    func backToProfile(_ coordinator: any Coordinator) {
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator}) {
            childCoordinators.remove(at: index)
        }
    }
}
