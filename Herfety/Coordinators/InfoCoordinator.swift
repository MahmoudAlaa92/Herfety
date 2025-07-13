//
//  InfoCoordinator.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 13/07/2025.
//

import UIKit

protocol InfoTransitionDelegate: AnyObject {
    func goToCheckoutVC()
}

class InfoCoordinator: Coordinator {
    
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
}
