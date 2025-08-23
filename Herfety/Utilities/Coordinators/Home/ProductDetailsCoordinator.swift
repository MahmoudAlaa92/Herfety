//
//  ProductsDetailsCoordinator.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 04/07/2025.
//

import UIKit

protocol PoroductsDetailsTransitionDelegate: AnyObject {
    func backToHomeVC()
    func backToProductsVC()
    func goToProductDetailsVC(productDetails: WishlistItem)
    func goToReviewersVC(productId: Int, reviewers: [ReviewrItem])
}

protocol PoroductsDetailsChildDelegate: AnyObject {
    func backToProductDetails(_ coordinator: Coordinator)
}

class PoroductDetailsCoordinator: Coordinator {
    weak var productsParentCoordinator: ProductsChildDelegate?
    weak var homeParentCoordinator: HomeChildProtocol?
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    var productDetails: WishlistItem
    let alertCoordinator: AlertPresenter
    
    init(navigationController: UINavigationController, productDetails: WishlistItem) {
        self.navigationController = navigationController
        self.productDetails = productDetails
        self.alertCoordinator = AlertCoordinator(presentingViewController: navigationController)
    }
    
    func start() {
        let viewModel = ProductDetailsViewModelFactory.creat(coordinator: self,
                                                             currentProductId: productDetails.productID ?? 93,
                                                             productItem: productDetails)
        Task { await viewModel.fetchData() }
        
        let productsDetailsVC = ProductDetailsViewController(viewModel: viewModel)
        productsDetailsVC.coordinator = self
        productsDetailsVC.alertPresenter = alertCoordinator
        navigationController.transition(to: productsDetailsVC, with: .push)
    }
    
    deinit {
        print("deinit \(Self.self)")
    }
}
// MARK: - Transition Delegate
//
extension PoroductDetailsCoordinator: PoroductsDetailsTransitionDelegate {

    func backToHomeVC() {
        homeParentCoordinator?.backToHome(self)
    }
    
    func backToProductsVC() {
        productsParentCoordinator?.backToProductsVC(self)
        navigationController.pop(with: .push)

    }
   // TODO: 'Change' the same coordinator
    func goToProductDetailsVC(productDetails: WishlistItem) {
        let coordinator = PoroductDetailsCoordinator(navigationController: navigationController, productDetails: productDetails)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func goToReviewersVC(productId: Int, reviewers: [ReviewrItem]) {
        let coordinator = ReviewersCoordinator(navigationController: navigationController, productId: productId, reviewers: reviewers)
        childCoordinators.append(coordinator)
        coordinator.parentCoordinator = self
        coordinator.start()
    }
}
// MARK: - Child Delegate
//
extension PoroductDetailsCoordinator: PoroductsDetailsChildDelegate {
    
    func backToProductDetails(_ coordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
    }
}
