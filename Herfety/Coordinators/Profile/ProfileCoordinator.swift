//
//  ProfileCoordinator.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 01/07/2025.
//

import UIKit
import SafariServices

protocol PorfileTransionDelegate: AnyObject {
    func gotToCartVC()
    func gotToWishlistVC()
    func gotToShippingVC()
    func gotToMyCardVC()
    func gotToSettingVC()
    func goToAuthVC()
    func gotToSafari(url: String)
}

protocol ProfileChildDelegate: AnyObject {
    func backToProfile(_ coordinator: Coordinator)
}

class ProfileCoordinator: Coordinator, ParentCartDelegate, ParentCheckoutDelegate {
    
    weak var parentCoordinator: TabBarTransitionDelegate?
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
        navigationController.transition(to: profileVC, with: .push)
    }
}
// MARK: - Transition Delegate
//
extension ProfileCoordinator: PorfileTransionDelegate {
    
    func gotToCartVC() {
        let coordinator = CartCoordinator(navigationController: navigationController, alertPresenter: alertPresenter)
        coordinator.isShowBackButton = true
        
        childCoordinators.append(coordinator)
        coordinator.parentCoordinator = self
        coordinator.start()
    }
    
    func gotToWishlistVC() {
        let coordinator = WishlistCoordinator(navigationController: navigationController,
                                              alertPresenter: alertPresenter)
        coordinator.isShowBackButton = true

        childCoordinators.append(coordinator)
        coordinator.parentCoordinator = self
        coordinator.start()
    }
    
    func gotToShippingVC() {
        let coordinator = InfoCoordinator(navigationController: navigationController,
                                          alertPresenter: alertPresenter)
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func gotToMyCardVC() {
        let coordinator = CheckoutCoordinator(navigationController: navigationController,
                                              alertPresenter: alertPresenter)
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func gotToSettingVC() {
        let coordinator = SettingCoordinator(navigationController: navigationController,
                                            alertPresenter: alertPresenter)
        coordinator.parentCoordinator = self
        coordinator.firstParentCoordinator = parentCoordinator
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func goToAuthVC() {
        parentCoordinator?.goToAuthVC()
    }
    
    func gotToSafari(url: String) {
        if let urlString = URL(string: url) {
            let safariVC = SFSafariViewController(url: urlString)
            safariVC.modalPresentationStyle = .pageSheet
            navigationController.present(safariVC, animated: true)
        }
    }
}
// MARK: - Child Delegate
//
extension ProfileCoordinator: ProfileChildDelegate {
    
    func backToProfile(_ coordinator: any Coordinator) {
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator}) {
            childCoordinators.remove(at: index)
        }
    }
    
    func removeCartChild(_ coordinator: any Coordinator) {
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator}) {
            childCoordinators.remove(at: index)
        }
    }
    
    func removeCheckoutChild(_ coordinator: any Coordinator) {
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator}) {
            childCoordinators.remove(at: index)
        }
    }
}
