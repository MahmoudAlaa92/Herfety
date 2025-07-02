//
//  SignUpCoordinator.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 01/07/2025.
//

import UIKit

protocol SignUpTransitionDelegate: AnyObject {
    func backToSplashVC()
}

class SignUpCoordinator: Coordinator {
    
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
        let signVC = SignupViewController()
        signVC.coordinator = self
        navigationController.pushViewController(signVC, animated: true)
    }
}
// MARK: - Transition Delegate
//
extension SignUpCoordinator: SignUpTransitionDelegate {
    func backToSplashVC() {
        parentCoordinator?.pop(self)
    }
}
