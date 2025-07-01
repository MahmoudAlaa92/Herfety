//
//  SignUpCoordinator.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 01/07/2025.
//

import UIKit

class SignUpCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let signVC = SignupViewController(viewModel: SignupViewModel())
        navigationController.pushViewController(signVC, animated: true)
    }
}
