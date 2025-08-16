//
//  SplashCoordinator.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 01/07/2025.
//

import UIKit

protocol SplashTransitionDelegate: AnyObject {
    func goLoginVC()
    func goSignUpVC()
}

protocol SplashChildDelegate: AnyObject {
    func pop(_ coordinator: Coordinator)
}

class SplashCoordinator: NSObject, Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var onLoginSuccess: (() -> Void)? // Add callback
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        print("deinit \(Self.self)")
    }
    
    func start() {
        let splashVC = SplashViewController(viewModel: SplashViewModel())
        splashVC.coordinator = self
        navigationController.transition(to: splashVC, with: .push)
    }
}
// MARK: - Transition Delegate
//
extension SplashCoordinator: SplashTransitionDelegate {
 
    func goLoginVC() {
        let coordinator = LoginCoordinator(navigationController: navigationController)
        coordinator.parentCoordinator = self
        coordinator.onLoginSuccess = { [weak self] in
            self?.onLoginSuccess?() /// Notify AppCoordinator
        }
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func goSignUpVC() {
        let coordinator = SignUpCoordinator(navigationController: navigationController)
        coordinator.parentCoordinator = self
        coordinator.onSignUpSuccess = { [weak self] in
            self?.onLoginSuccess?() /// Notify AppCoordinator
        }
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}
// MARK: - Child Delegate
//
extension SplashCoordinator: SplashChildDelegate {
    func pop(_ coordinator: any Coordinator) {
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator}) {
            childCoordinators.remove(at: index)
        }
    }
}
