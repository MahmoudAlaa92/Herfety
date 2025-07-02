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
    
    private var window: UIWindow?
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
    }
    
    deinit {
        print("deinit \(Self.self)")
    }
    
    func start() {
        // Check if user is logged in
        if UserSessionManager.isLoggedIn {
            showMainTabFlow()
        } else {
            showAuthFlow()
        }
    }
    
    private func showAuthFlow() {
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
        let tabCoordinator = TabBarCoordinator(navigationController: navigationController)
        childCoordinators.append(tabCoordinator)
        tabCoordinator.start()
        
        // Update window root without animation
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    private func removeAuthCoordinators() {
        childCoordinators.removeAll { coordinator in
            coordinator is SplashCoordinator ||
            coordinator is LoginCoordinator  ||
            coordinator is SignUpCoordinator
        }
    }
}

// UserSessionManager.swift
class UserSessionManager {
    static var isLoggedIn: Bool {
        get { UserDefaults.standard.bool(forKey: "isLoggedIn") }
        set { UserDefaults.standard.set(newValue, forKey: "isLoggedIn") }
    }
}
