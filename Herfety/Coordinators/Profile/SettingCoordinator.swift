//
//  SettingCoordinator.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 20/07/2025.
//

import UIKit

protocol SettingTransitionDelegate: AnyObject {
    func backToProfileVC()
}

class SettingCoordinator: Coordinator {
    var parentCoordinator: ProfileChildDelegate?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    let alerPresneter: AlertPresenter
    
    init(navigationController: UINavigationController, alertPresenter: AlertPresenter) {
        self.navigationController = navigationController
        self.alerPresneter = alertPresenter
    }
    
    func start() {
        let viewModel = SettingViewModel()
        let settingVC = SettingViewController(settingViewModel: viewModel)
        
        settingVC.coordinatorTwo = self
        navigationController.transition(to: settingVC, with: .push)
    }
    
    deinit {
        print("deinit \(Self.self)")
    }
}
// MARK: - Transtion Delegate
//
extension SettingCoordinator: SettingTransitionDelegate {
    func backToProfileVC() {
        parentCoordinator?.backToProfile(self)
        navigationController.pop(with: .push)
    }
}
