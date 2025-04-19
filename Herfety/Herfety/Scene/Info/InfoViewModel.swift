//
//  InfoViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 13/02/2025.
//
import UIKit
import Combine

class InfoViewModel {
    // MARK: - Properties
    var infoItems: [InfoModel] = []
    var navigationToPayment: (()-> Void)?
    
    init() {
      observeInfoItems()
    }
    func numberOfItems() -> Int {
        return infoItems.count
    }
    func didTapPlusButton(navigationController: UINavigationController?) {
        // navigate to address screen
        let addressVC = AddAddressViewController(viewModel: AddAddressViewModel())
        navigationController?.pushViewController(addressVC, animated: true)
    }
    func didTapPaymentButton() {
        if infoItems.isEmpty {
            // Show Alert of Warning
            print("Show Alert Warning")
        }else{
            // Show Credit
            navigationToPayment?()
        }
    }
}
// MARK: - Privagte Handlers
//
extension InfoViewModel {
    private func observeInfoItems() {
        CustomeTabBarViewModel.shared.$infos.sink { [weak self] infoItems in
            self?.infoItems = infoItems
        }.store(in: &CustomeTabBarViewModel.shared.subscriptions)
    }
}
