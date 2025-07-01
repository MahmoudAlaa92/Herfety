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
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        print("deinit \(Self.self)")
    }
    
    func start() {
        let loginVC = LoginViewController(viewModel: LoginViewModel())
//        loginVC.coordinator = self
        navigationController.pushViewController(loginVC, animated: true)
    }
}
// MARK: - Transition Delegate
//
extension LoginCoordinator: LoginTransitionDelegate {
    func backToSplash() {
        parentCoordinator?.pop(self)
    }
}
