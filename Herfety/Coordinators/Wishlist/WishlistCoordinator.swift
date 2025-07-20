//
//  WishlistCoordinator.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 01/07/2025.
//

import UIKit

protocol WishlistTransitionDelegate: AnyObject {
    func backToProfileVC()
}

class WishlistCoordinator: Coordinator {
    
    weak var parentCoordinator: ProfileChildDelegate?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    let alertPresenter: AlertPresenter
    var isShowBackButton: Bool = false

    init(navigationController: UINavigationController, alertPresenter: AlertPresenter) {
        self.navigationController = navigationController
        self.alertPresenter = alertPresenter
    }
    
    deinit {
        print("deinit \(Self.self)")
    }
    
    func start() {
        let wishlistVC = WishListViewController()
        wishlistVC.isShowBackButton = isShowBackButton
        wishlistVC.coordinator = self
        navigationController.transition(to: wishlistVC, with: .push)
    }
}
// MARK: - Transition Delegate
//
extension WishlistCoordinator: WishlistTransitionDelegate {
    func backToProfileVC() {
        parentCoordinator?.backToProfile(self)
        navigationController.pop(with: .push)
    }
}
