//
//  AppCoordinator.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 01/07/2025.
//

import UIKit

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
        /// Check if user is logged in
        if UserSessionManager.isLoggedIn {
            showMainTabFlow()
        } else {
            showAuthFlow()
        }
    }
    
    private func showAuthFlow() {
        /// let authNav = UINavigationController()
        let splashCoordinator = SplashCoordinator(navigationController: navigationController)
        splashCoordinator.onLoginSuccess = { [weak self] in
            self?.showMainTabFlow()
            self?.removeAuthCoordinators()
        }
        
        childCoordinators.append(splashCoordinator)
        splashCoordinator.start()
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    private func showMainTabFlow() {
        let tabCoordinator = TabBarCoordinator(alertPresenter: alertPresenter)
        childCoordinators.append(tabCoordinator)
        tabCoordinator.start()
        
        // Update window root without animation
        window?.rootViewController = tabCoordinator.tabBarController
        window?.makeKeyAndVisible()
    }
    
    private func removeAuthCoordinators() {
        print("Removing auth coordinators...")
        print("Before removal: \(childCoordinators.map { String(describing: type(of: $0)) })")
        childCoordinators.removeAll { coordinator in
            coordinator is SplashCoordinator ||
            coordinator is LoginCoordinator  ||
            coordinator is SignUpCoordinator
        }
        print("After removal: \(childCoordinators.map { String(describing: type(of: $0)) })")
    }
}
