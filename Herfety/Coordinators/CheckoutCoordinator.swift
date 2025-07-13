//
//  CheckoutCoordinator.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 13/07/2025.
//

import UIKit

protocol CheckoutTransionDelegate: AnyObject {
    func backToInfoVC()
}

class CheckoutCoordinator: Coordinator {
    
    weak var parectCoordinator: InfoChildDelegate?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let checkoutVC = MyCheckoutViewController()
        
        navigationController.pushViewController(checkoutVC, animated: true)
    }

    deinit {
        print("deninit \(Self.self)")
    }
    
}
// MARK: - Transtion Delegate
//
extension CheckoutCoordinator: CheckoutTransionDelegate {
    func backToInfoVC() {
        parectCoordinator?.backToInfoVC(self)
        navigationController.popViewController(animated: true)
    }
}
