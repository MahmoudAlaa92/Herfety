//
//  ProfileCoordinator.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 01/07/2025.
//

import UIKit

class ProfileCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        print("deinit \(Self.self)")
    }
    
    func start() {
        let profileVC = ProfileViewController(
            nameViewModel: NameViewModel(),
            profileListViewModel: ProfileListViewModel()
        )
        navigationController.pushViewController(profileVC, animated: false)
    }
}
