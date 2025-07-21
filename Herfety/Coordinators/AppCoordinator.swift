//
//  AppCoordinator.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 01/07/2025.
//

import UIKit

protocol AppTransitionDelegate: AnyObject {
    func didRequestLogout()
}

class AppCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    private var alertPresenter: AlertPresenter
    private var window: UIWindow?
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
        self.alertPresenter = AlertCoordinator(presentingViewController: navigationController)
    }
    
    deinit {
        print("deinit \(Self.self)")
    }
    
    func start() {
        if UserSessionManager.isLoggedIn {
            showMainTabFlow()
        } else {
            showAuthFlow()
        }
    }
}
// MARK: - Private Handler
//
extension AppCoordinator {
    private func showAuthFlow() {
        let splashCoordinator = SplashCoordinator(navigationController: navigationController)
        splashCoordinator.onLoginSuccess = { [weak self] in
            self?.showMainTabFlow()
            self?.removeAuthCoordinators()
        }
        
        childCoordinators.append(splashCoordinator)
        splashCoordinator.start()
        
        window?.setRootViewController(navigationController,with: .fade)
    }
    
    private func showMainTabFlow() {
        let tabCoordinator = TabBarCoordinator(alertPresenter: alertPresenter)
        tabCoordinator.parentCoordinator = self
        childCoordinators.append(tabCoordinator)
        tabCoordinator.start()
        
        window?.setRootViewController(tabCoordinator.tabBarController, with: .fade)
    }
    
    private func removeAuthCoordinators() {
        print("Before removal: \(childCoordinators.map { String(describing: type(of: $0)) })")
        childCoordinators.removeAll { coordinator in
            coordinator is SplashCoordinator ||
            coordinator is LoginCoordinator  ||
            coordinator is SignUpCoordinator
        }
        print("After removal: \(childCoordinators.map { String(describing: type(of: $0)) })")
    }
    
    private func removeTabBarCoordinators() {
        print("Before removal: \(childCoordinators.map { String(describing: type(of: $0)) })")
        childCoordinators.removeAll()
        print("After removal: \(childCoordinators.map { String(describing: type(of: $0)) })")
    }
}
// MARK: - Transitino Delegate
//
extension AppCoordinator: AppTransitionDelegate {
    func didRequestLogout() {
        UserSessionManager.isLoggedIn = false
        navigationController.viewControllers = []
        removeTabBarCoordinators()
        showAuthFlow()
    }
}
