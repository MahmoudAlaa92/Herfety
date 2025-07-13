//
//  CartCoordinator.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 01/07/2025.
//

import UIKit

protocol CartTransitionDelegate: AnyObject {
    func goToInfoVC()
}

class CartCoordinator: Coordinator {
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
        let cartVC = OrderViewController()
        cartVC.coordinator = self
        cartVC.alertPresenter = alertPresenter
        navigationController.pushViewController(cartVC, animated: false)
    }
}

extension CartCoordinator: CartTransitionDelegate {
    func goToInfoVC() {
        let coordinator = InfoCoordinator(navigationController: navigationController)
        coordinator.childCoordinators.append(coordinator)
        coordinator.start()
    }
}
