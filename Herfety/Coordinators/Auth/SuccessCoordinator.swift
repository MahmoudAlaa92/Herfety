//
//  SuccessCoordinator.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 04/07/2025.
//

import UIKit

protocol SuccessTransitionDelegate: AnyObject {}

class SuccessCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var onStartShoping: (() -> Void)?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = SuccessViewModel()
        viewModel.onStartShopping = { [weak self] in
            self?.onStartShoping?()
        }
        let SuccessVC = SuccessViewController(viewModel: viewModel)
        SuccessVC.coordinator = self
        SuccessVC.modalPresentationStyle = .fullScreen
        navigationController.present(SuccessVC, with: .fade)
    }
    
    deinit {
        print("deinit \(Self.self)")
    }
    
}
// MARK: - Transition Delegate
//
extension SuccessCoordinator: SuccessTransitionDelegate {
    
}
