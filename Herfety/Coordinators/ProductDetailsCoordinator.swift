//
//  ProductsDetailsCoordinator.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 04/07/2025.
//

import UIKit

protocol PoroductsDetailsTransitionDelegate: AnyObject  {
    func backToProductsVC()
    func goToProductDetailsVC(productDetails: Wishlist)
    func goToReviewersVC(productId: Int, reviewers: [Reviewrr])
    
}

protocol PoroductsDetailsChildDelegate: AnyObject  {
    func backToProductDetails(_ coordinator: Coordinator)
 
}

class PoroductDetailsCoordinator: Coordinator {
    weak var parentCoordinator: ProductsChildDelegate?
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    var productDetails: Wishlist

    init(navigationController: UINavigationController, productDetails: Wishlist) {
        self.navigationController = navigationController
        self.productDetails = productDetails
    }
    
    func start() {
        let viewModel = ProductDetailsViewModel(productId: productDetails.productID ?? 93)
        viewModel.productItem = productDetails
        viewModel.fetchProductItems()

        let productsDetialsVC = ProductDetailsViewController(viewModel: viewModel)
        productsDetialsVC.coordinator = self
        navigationController.pushViewController(productsDetialsVC, animated: true)
    }
    
    deinit {
        print("deinit \(Self.self)")
    }
}
// MARK: - Transition Delegate
//
extension PoroductDetailsCoordinator: PoroductsDetailsTransitionDelegate {
    
    func backToProductsVC() {
        parentCoordinator?.backToProductsVC(self)
        navigationController.popViewController(animated: true)
    }
   // TODO: 'Change' the same coordinator
    func goToProductDetailsVC(productDetails: Wishlist) {
        let coordinator = PoroductDetailsCoordinator(navigationController: navigationController, productDetails: productDetails)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func goToReviewersVC(productId: Int, reviewers: [Reviewrr]) {
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
