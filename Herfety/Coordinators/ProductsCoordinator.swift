//
//  ProductsCoordinator.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 04/07/2025.
//

import UIKit

protocol ProductsTransitionDelegate: AnyObject {
    func goToProductDetails()
    func backToHomeVC()
}

class ProductsCoordinator: Coordinator {
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
// MARK: - Transition Delegate
extension ProductsCoordinator: ProductsTransitionDelegate {
    
    func backToHomeVC() {
        parentCoordinator?.backToHome(self)
    }
    
    func goToProductDetails() {
        
    }
}
