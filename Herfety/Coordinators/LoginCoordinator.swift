//
//  LoginCoordinator.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 01/07/2025.
//

import UIKit

protocol LoginTransitionDelegate: AnyObject {
    func backToSplash()
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
        loginVC.onLoginSuccess = { [weak self] in
            self?.onLoginSuccess?() // Trigger success callback
        }
        navigationController.pushViewController(loginVC, animated: true)
    }
    
    deinit {
        print("deinit \(Self.self)")
    }
    
}
// MARK: - Transition Delegate
//
extension LoginCoordinator: LoginTransitionDelegate {
    func backToSplash() {
        parentCoordinator?.pop(self)
    }
}
