//
//  InfoCoordinator.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 13/07/2025.
//

import UIKit

protocol InfoTransitionDelegate: AnyObject {
    func goToCheckoutVC()
    func backToCartVC()
}

protocol InfoChildDelegate: AnyObject {
    func backToInfoVC(_ coordinator: Coordinator)
}

class InfoCoordinator: Coordinator {
    weak var parentCoordinator: CartChildDelegate?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let shippingVC = InfoViewController()
        shippingVC.coordinator = self
        self.navigationController.pushViewController(shippingVC, animated: true)
    }
    
    deinit {
        print("deinit \(Self.self)")
    }
}
// MARK: - Transition Delegate
//
extension InfoCoordinator: InfoTransitionDelegate {
    
    func goToCheckoutVC() {
        
    }
    
    func backToCartVC() {
        parentCoordinator?.backToCartVC(self)
        navigationController.popViewController(animated: true)
    }
}
// MARK: - Child Delegate
//
extension InfoCoordinator: InfoChildDelegate {
    func backToInfoVC(_ coordinator:  Coordinator) {
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
    }
}
