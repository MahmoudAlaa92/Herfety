//
//  ForgetPasswordCoordinator.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 09/08/2025.
//

import UIKit

protocol ForgetPasswordTransitonDelegate: AnyObject {
    func backToLoginVC()
}

class ForgetPasswordCoordinator: Coordinator {
    
    weak var parentCoordinator: LoginChildDelegate?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    func start() {
        let vc = ForgetPasswordViewController()
        vc.coordinator = self
        navigationController.transition(to: vc, with: .push)
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        print("deinit \(Self.self)")
    }
}
// MARK: - Transition
//
extension ForgetPasswordCoordinator: ForgetPasswordTransitonDelegate {
    func backToLoginVC() {
        parentCoordinator?.pop(self)
        navigationController.pop(with: .push)
    }
}
