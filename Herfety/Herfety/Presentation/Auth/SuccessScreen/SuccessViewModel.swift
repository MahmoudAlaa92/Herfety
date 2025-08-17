//
//  SuccessViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 13/08/2025.
//

import Foundation

final class SuccessViewModel: SuccessViewModelType {
    // MARK: - Coordinator/Callback
    var onStartShopping: (() -> Void)?
    
    // MARK: - Actions
    func startShoppingTapped() {
        onStartShopping?()
    }
}
