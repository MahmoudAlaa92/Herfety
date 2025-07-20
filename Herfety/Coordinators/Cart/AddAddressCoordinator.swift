//
//  AddAddressCoordinator.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 13/07/2025.
//

import UIKit

protocol AddAddressChildDelegate: AnyObject {
    func backToInfoVC()
}

class AddAddressCoordinator: Coordinator {
    weak var parentCoordinator: ParentCheckoutDelegate?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    let alertPresenter: AlertPresenter
    
    init(navigationController: UINavigationController, alertPresenter: AlertPresenter) {
        self.navigationController = navigationController
        self.alertPresenter = alertPresenter
    }
    
    func start() {
        let addressVC = AddAddressViewController(viewModel: AddAddressViewModel())
        addressVC.coordinator = self
        addressVC.alertPresenter = alertPresenter
        navigationController.transition(to: addressVC, with: .push)
    }

    deinit {
        print("deinit \(Self.self)")
    }
}
// MARK: - Child Delegate
//
extension AddAddressCoordinator: AddAddressChildDelegate {
    func backToInfoVC() {
        parentCoordinator?.removeCheckoutChild(self)
        navigationController.pop(with: .push)
    }
}
