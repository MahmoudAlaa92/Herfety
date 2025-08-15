//
//  AddReviewsCoordinator.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 06/07/2025.
//

import UIKit

protocol AddReviewsChildDelegate: AnyObject {
    func backToReviewersVC()
}

class AddReviewsCoordinator: Coordinator {
    
    weak var parentCoordinator: ReviewersChildDelegate?
    var childCoordinators = [ Coordinator]()
    var navigationController: UINavigationController
    var viewModel: AddReviewViewModel
    let alertPresneter: AlertPresenter
    
    init(navigationController: UINavigationController, viewModel: AddReviewViewModel) {
        self.navigationController = navigationController
        self.viewModel = viewModel
        self.alertPresneter = AlertCoordinator(presentingViewController: navigationController)
    }
    
    func start() {
        let viewModel = AddReviewViewModel(reviersItems: viewModel.reviersItems, productId: viewModel.productId)
        let addReviewsVC = AddReviewViewController(viewModel: viewModel)
        
        addReviewsVC.coordinator = self
        addReviewsVC.alertPresenter = alertPresneter
        navigationController.transition(to: addReviewsVC, with: .push)
    }
    
    deinit {
        print("deinit \(Self.self)")
    }
}
// MARK: - Transition Delegate
//
extension AddReviewsCoordinator: AddReviewsChildDelegate {
    
    func backToReviewersVC() {
        parentCoordinator?.backToReviewersVC(self)
        navigationController.pop(with: .push)
    }
}
