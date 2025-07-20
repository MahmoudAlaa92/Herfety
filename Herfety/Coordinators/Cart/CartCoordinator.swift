//
//  CartCoordinator.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 01/07/2025.
//

import UIKit

protocol CartTransitionDelegate: AnyObject {
    func goToInfoVC()
    func backToProfileVC()
}

protocol ParentCartDelegate: AnyObject {
    func removeCartChild(_ coordinator: Coordinator)
}

class CartCoordinator: Coordinator {
    
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
        
        let cartVC = CartViewController()
        cartVC.coordinator = self
        cartVC.alertPresenter = alertPresenter
        cartVC.isShowBackButton = isShowBackButton
        navigationController.transition(to: cartVC, with: .push)
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
    
    func backToProfileVC() {
        parentCoordinator?.backToProfile(self)
        navigationController.pop(with: .push)
    }
}
// MARK: - Child Delegate
//
extension CartCoordinator: ParentCartDelegate {
    func removeCartChild(_ coordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator}) {
            childCoordinators.remove(at: index)
        }
    }
}
