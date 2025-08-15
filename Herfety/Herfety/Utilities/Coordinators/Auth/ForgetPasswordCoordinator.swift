//
//  ForgetPasswordCoordinator.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 09/08/2025.
//

import UIKit

protocol ForgetPasswordTransitonDelegate: AnyObject {
    func backToLoginVC()
    func goToSuccessVC()
}

class ForgetPasswordCoordinator: Coordinator {
    
    weak var parentCoordinator: LoginChildDelegate?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    let alertCoordinator: AlertPresenter
    var onStartShoping: (() -> Void)? /// Add callback

    func start() {
        let viewModel = ForgetPasswordViewModel()
        let vc = ForgetPasswordViewController(viewModel: viewModel)
        vc.coordinator = self
        vc.alertPresenter = alertCoordinator
        navigationController.transition(to: vc, with: .push)
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.alertCoordinator = AlertCoordinator(presentingViewController: navigationController)
    }
    
    deinit {
        print("deinit \(Self.self)")
    }
}
// MARK: - Transition
//
extension ForgetPasswordCoordinator: ForgetPasswordTransitonDelegate {
    func backToLoginVC() {
        parentCoordinator?.pop(self)
        navigationController.pop(with: .push)
    }
    
    func goToSuccessVC() {
        let coordinator = SuccessCoordinator(navigationController: navigationController)
        coordinator.onStartShoping = { [weak self] in
            self?.onStartShoping?()
        }
        childCoordinators.append(coordinator)
        coordinator.start()
    }

}
