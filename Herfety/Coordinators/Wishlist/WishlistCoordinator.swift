//
//  WishlistCoordinator.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 01/07/2025.
//

import UIKit

class WishlistCoordinator: Coordinator {
    
    weak var parentCoordinator: PorfileTransionDelegate?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    let alertPresenter: AlertPresenter
    
    init(navigationController: UINavigationController, alertPresenter: AlertPresenter) {
        self.navigationController = navigationController
        self.alertPresenter = alertPresenter
    }
    
    deinit {
        print("deinit \(Self.self)")
    }
    
    func start() {
        let wishlistVC = WishListViewController()
        navigationController.transition(to: wishlistVC, with: .push)
    }
}
