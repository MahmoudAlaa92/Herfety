//
//  HomeCoordinator.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 01/07/2025.
//

import UIKit

protocol HomeTranisitionDelegate: AnyObject {
    func goToSliderItem(discount: Int)
    func goToCategoryItem(category Name: String)
    func gotToBestDealItem(productDetails: Wishlist)
    func gotToTopBrandItem(discount: Int)
    func gotToDailyEssentialItem(discount: Int)
}

protocol HomeChildDelegate: AnyObject {
    func backToHome(_ coordinator: Coordinator)
}

class HomeCoordinator: NSObject, Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        print("deinit \(Self.self)")
    }
    
    func start() {
        let homeVC = HomeViewController()
        homeVC.coordinator = self
        
        navigationController.pushViewController(homeVC, animated: false)
    }
}
// MARK: - Home Transition Delegate
//
extension HomeCoordinator: HomeTranisitionDelegate {
    
    func goToSliderItem(discount: Int) {
        let coordinator = ProductsCoordinator(
            navigationController: navigationController)
        coordinator.discount = discount
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func goToCategoryItem(category Name: String) {
        let coordinator = ProductsCoordinator(
            navigationController: navigationController)
        coordinator.parentCoordinator = self
        coordinator.categoryName = Name
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func gotToBestDealItem(productDetails: Wishlist) {
     
    }

    func gotToTopBrandItem(discount: Int) {
        let coordinator = ProductsCoordinator(
            navigationController: navigationController)
        coordinator.discount = discount
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func gotToDailyEssentialItem(discount: Int) {
        let coordinator = ProductsCoordinator(
            navigationController: navigationController)
        coordinator.discount = discount
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}
// MARK: - ChildDelegate
//
extension HomeCoordinator: HomeChildDelegate {
    
    func backToHome(_ coordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator } ){
            childCoordinators.remove(at: index)
        }
    }
}
