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
    private var discount: Int
    
    init(navigationController: UINavigationController, discount: Int) {
        self.navigationController = navigationController
        self.discount = discount
    }
    
    func start() {
        let viewModel = ProductsViewModel()
        viewModel.fetchProductItems(discount: discount)
        let ProductsVC = ProductsViewController(viewModel: viewModel)
        
        ProductsVC.coordinator = self
        navigationController.pushViewController(ProductsVC, animated: true)
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
        navigationController.popViewController(animated: true)
    }
    
    func goToProductDetails(productDetails: Wishlist) {
        let coordinator = PoroductDetailsCoordinator(navigationController: navigationController, productDetails: productDetails)
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}
