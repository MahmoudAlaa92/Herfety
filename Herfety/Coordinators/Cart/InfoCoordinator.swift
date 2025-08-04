//
//  InfoCoordinator.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 13/07/2025.
//

import UIKit

protocol InfoTransitionDelegate: AnyObject {
    func goToCheckoutVC()
    func goToAddAddressVC()
    func backToCartVC()
}

protocol ParentCheckoutDelegate: AnyObject {
    func removeCheckoutChild(_ coordinator: Coordinator)
}

class InfoCoordinator: Coordinator {
    weak var parentCoordinator: ParentCartDelegate?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    let alertPresenter: AlertPresenter
    
    init(navigationController: UINavigationController, alertPresenter: AlertPresenter) {
        self.navigationController = navigationController
        self.alertPresenter = alertPresenter
    }
    
    func start() {
        let shippingVC = InfoViewController()
        shippingVC.coordinator = self
        shippingVC.alertPresenter = alertPresenter
        navigationController.transition(to: shippingVC, with: .push)
    }
    
    deinit {
        print("deinit \(Self.self)")
    }
}
// MARK: - Transition Delegate
//
extension InfoCoordinator: InfoTransitionDelegate {
    
    func goToCheckoutVC() {
        let coordinator = CheckoutCoordinator(navigationController: navigationController, alertPresenter: alertPresenter)
        childCoordinators.append(coordinator)
        coordinator.parentCoordinator = self
        coordinator.start()
    }
    
    func goToAddAddressVC() {
        let coordinator = AddAddressCoordinator(navigationController: navigationController, alertPresenter: alertPresenter)
        childCoordinators.append(coordinator)
        coordinator.parentCoordinator = self
        coordinator.start()
    }
    
    func backToCartVC() {
        parentCoordinator?.removeCartChild(self)
        navigationController.pop(with: .push)
    }
}
// MARK: - Child Delegate
//
extension InfoCoordinator: ParentCheckoutDelegate {
    func removeCheckoutChild(_ coordinator:  Coordinator) {
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
    }
}
