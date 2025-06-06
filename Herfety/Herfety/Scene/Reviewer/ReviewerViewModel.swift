//
//  ReviewerViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 03/03/2025.
//

import UIKit

class ReviewerViewModel {
    var reviersItems: [Reviewrr] = [ ]
    var didTapPlusButton: (() -> Void)?
    
    func didTapPlusButton(navigationController: UINavigationController?) {
        // navigate to add comment
        let addressVC = AddReviewViewController(viewModel: AddReviewViewModel())
        navigationController?.pushViewController(addressVC, animated: true)
    }
}
