//
//  ProductsCoordinator.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 04/07/2025.
//

import UIKit

protocol ProductsTransitionDelegate: AnyObject {
    func goToProductDetails(productDetails: Wishlist)
    func backToHomeVC()
}

protocol ProductsChildDelegate: AnyObject {
    func backToProductsVC(_ coordinator: Coordinator)
}

class ProductsCoordinator: NSObject, Coordinator {

    weak var parentCoordinator: HomeChildDelegate?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var discount: Int = 0
    var categoryName: String = ""
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = ProductsViewModel()
        if discount != 0 { viewModel.fetchProductItems(discount: discount) }
        if !categoryName.isEmpty{ viewModel.fetchProductItems(nameOfCategory: categoryName) }
        
        let ProductsVC = ProductsViewController(viewModel: viewModel)
        ProductsVC.coordinator = self
        navigationController.transition(to: ProductsVC, with: .push)
    }
    
    deinit {
        print("deinit \(Self.self)")
    }
}
// MARK: - Child Delegate
//
extension ProductsCoordinator: ProductsChildDelegate {
    func backToProductsVC(_ coordinator: any Coordinator) {
        
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
    }
}
// MARK: - Transition Delegate
//
extension ProductsCoordinator: ProductsTransitionDelegate {
    
    func backToHomeVC() {
        parentCoordinator?.backToHome(self)
        navigationController.pop(with: .push)
    }
    
    func goToProductDetails(productDetails: Wishlist) {
        let coordinator = PoroductDetailsCoordinator(navigationController: navigationController, productDetails: productDetails)
        coordinator.productsParentCoordinator = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}

