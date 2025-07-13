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

protocol CartChildDelegate: AnyObject {
    func backToCartVC(_ coordinator: Coordinator)
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
// MARK: - Transition Delegate
//
extension CartCoordinator: CartTransitionDelegate {
    func goToInfoVC() {
        let coordinator = InfoCoordinator(navigationController: navigationController, alertPresenter: alertPresenter)
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}
// MARK: - Transition Delegate
//
extension CartCoordinator: CartChildDelegate {
    func backToCartVC(_ coordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator}) {
            childCoordinators.remove(at: index)
        }
    }
}
