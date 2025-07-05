//
//  ProductsDetailsCoordinator.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 04/07/2025.
//

import UIKit

protocol PoroductsDetailsChildDelegate: AnyObject  {
    func backToProductsVC()
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
extension PoroductDetailsCoordinator: PoroductsDetailsChildDelegate {
    func backToProductsVC() {
        parentCoordinator?.backToProductsVC(self)
        navigationController.popViewController(animated: true)
    }
}
