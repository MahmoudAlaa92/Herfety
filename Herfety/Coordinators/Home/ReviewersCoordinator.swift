//
//  ReviewersCoordinator.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 05/07/2025.
//

import UIKit

protocol ReviewersTransitionDelegate: AnyObject {
    func backToProductDetialsVC()
    func goToAddReviewersVC(viewModel: AddReviewViewModel)
}

protocol ReviewersChildDelegate: AnyObject {
    func backToReviewersVC(_ coordinator: Coordinator)
}

class ReviewersCoordinator: Coordinator {
    weak var parentCoordinator: PoroductsDetailsChildDelegate?
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    var productId: Int
    var reviewers: [Reviewrr]
    
    init(navigationController: UINavigationController, productId: Int, reviewers: [Reviewrr]) {
        self.navigationController = navigationController
        self.productId = productId
        self.reviewers = reviewers
    }
    
    func start() {
        let viewModel = ReviewersViewModel(productId: productId)
        viewModel.reviewersItems = reviewers
        
        let reviewrsVC = ReviewersViewController(viewModel: viewModel)
        reviewrsVC.coordinator = self
        navigationController.pushViewController(reviewrsVC, animated: true)
    }
    
    deinit {
        print("deinit \(Self.self)")
    }
}
// MARK: - Transition Delegate
//
extension ReviewersCoordinator: ReviewersTransitionDelegate {
    
    func backToProductDetialsVC() {
        parentCoordinator?.backToProductDetails(self)
        navigationController.popViewController(animated: true)
    }
    
    func goToAddReviewersVC(viewModel: AddReviewViewModel) {
        let coordinator = AddReviewsCoordinator(navigationController: navigationController, viewModel: viewModel)
        childCoordinators.append(coordinator)
        coordinator.parentCoordinator = self
        coordinator.start()
    }
}
// MARK: - Child Delegate
//
extension ReviewersCoordinator: ReviewersChildDelegate {
    func backToReviewersVC(_ coordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
    }
}
