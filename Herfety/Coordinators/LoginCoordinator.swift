//
//  LoginCoordinator.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 01/07/2025.
//

import UIKit

protocol LoginTransitionDelegate: AnyObject {
    func backToSplash()
    func goToSuccessVC()
}

class LoginCoordinator: Coordinator {
    
    weak var parentCoordinator: SplashChildDelegate?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var onLoginSuccess: (() -> Void)? // Add callback
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let loginVC = LoginViewController(viewModel: LoginViewModel())

        loginVC.coordinator = self
        navigationController.pushViewController(loginVC, animated: true)
    }
    
    deinit {
        print("deinit \(Self.self)")
    }
    
}
// MARK: - Transition Delegate
//
extension LoginCoordinator: LoginTransitionDelegate {
    func goToSuccessVC() {
        let coordinator = SuccessCoordinator(navigationController: navigationController)
        coordinator.onStartShoping = { [weak self] in
            self?.onLoginSuccess?()
        }
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    func backToSplash() {
        parentCoordinator?.pop(self)
    }
}
