//
//  HomeCoordinator.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 01/07/2025.
//

import UIKit
import SafariServices

protocol HomeTranisitionDelegate: AnyObject {
    func goToSearchVC(discount: Int)
    func gotToSafari(url: String)
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
    let alertPresenter: AlertPresenter

    init(navigationController: UINavigationController, alertPresenter: AlertPresenter) {
        self.navigationController = navigationController
        self.alertPresenter = alertPresenter
    }
    
    deinit {
        print("deinit \(Self.self)")
    }
    
    func start() {
        let viewModel = HomeViewModel(coordinator: self)
        let homeVC = HomeViewController(viewModel: viewModel)
        homeVC.coordinator = self
        homeVC.alertPresenter = alertPresenter
        navigationController.transition(to: homeVC, with: .push)
    }
}
// MARK: - Home Transition Delegate
//
extension HomeCoordinator: HomeTranisitionDelegate {
    
    func gotToSafari(url: String) {
        if let urlString = URL(string: url) {
            let safariVC = SFSafariViewController(url: urlString)
            safariVC.modalPresentationStyle = .pageSheet
            self.navigationController.present(safariVC, animated: true)
        }
    }
    
    func goToSearchVC(discount: Int) {
        self.showDiscountProducts(discount: discount)
    }
    
    func goToSliderItem(discount: Int) {
        self.showDiscountProducts(discount: discount)
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
        let coordinator = PoroductDetailsCoordinator(navigationController: navigationController, productDetails: productDetails)
        coordinator.homeParentCoordinator = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }

    func gotToTopBrandItem(discount: Int) {
        self.showDiscountProducts(discount: discount)
    }
    
    func gotToDailyEssentialItem(discount: Int) {
        self.showDiscountProducts(discount: discount)
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
// MARK: - private Handler
//
extension HomeCoordinator {
    func showDiscountProducts(discount: Int) {
        let coordinator = ProductsCoordinator(
            navigationController: navigationController)
        coordinator.discount = discount
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}
