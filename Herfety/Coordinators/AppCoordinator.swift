//
//  AppCoordinator.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 01/07/2025.
//

import UIKit

class AppCoordinator: Coordinator {
    var childCoordinators  = [Coordinator]()
    var navigationController = UINavigationController()
    
    private var window: UIWindow?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    deinit {
        print("deinit \(Self.self)")
    }
    
    func start() {
        let splashCoordinator = SplashCoordinator(navigationController: navigationController)
        childCoordinators.append(splashCoordinator)
        splashCoordinator.start()
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
