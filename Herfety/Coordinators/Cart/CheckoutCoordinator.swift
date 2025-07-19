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
    
    weak var parentCoordinator: InfoChildDelegate?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    let alertPresenter: AlertPresenter
    
    init(navigationController: UINavigationController, alertPresenter: AlertPresenter) {
        self.navigationController = navigationController
        self.alertPresenter = alertPresenter
    }
    
    func start() {
        let checkoutVC = MyCheckoutViewController(viewModel: CheckoutViewModel())
        checkoutVC.alertPresenter = alertPresenter
        checkoutVC.coordinator = self
        navigationController.transition(to: checkoutVC, with: .push)
    }

    deinit {
        print("deninit \(Self.self)")
    }
    
}
// MARK: - Transtion Delegate
//
extension CheckoutCoordinator: CheckoutTransionDelegate {
    func backToInfoVC() {
        parentCoordinator?.backToInfoVC(self)
        navigationController.pop(with: .push)
    }
}
