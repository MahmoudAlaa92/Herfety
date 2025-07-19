//
//  SignUpCoordinator.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 01/07/2025.
//

import UIKit

protocol SignUpTransitionDelegate: AnyObject {
    func backToSplashVC()
    func goToSuccessVC()
}

class SignUpCoordinator: Coordinator {
    
    weak var parentCoordinator: SplashChildDelegate?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var onSignUpSuccess: (() -> Void)?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        print("deinit \(Self.self)")
    }
    
    func start() {
        let signVC = SignupViewController()
        signVC.coordinator = self
        navigationController.transition(to: signVC, with: .push)
    }
}
// MARK: - Transition Delegate
//
extension SignUpCoordinator: SignUpTransitionDelegate {
    func goToSuccessVC() {
        let coordinator = SuccessCoordinator(navigationController: navigationController)
        coordinator.onStartShoping = { [weak self] in
            self?.onSignUpSuccess?()
        }
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func backToSplashVC() {
        parentCoordinator?.pop(self)
    }
}
