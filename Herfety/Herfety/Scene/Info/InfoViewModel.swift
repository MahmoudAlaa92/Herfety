import Combine
//
//  InfoViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 13/02/2025.
//
import UIKit

class InfoViewModel {
    // MARK: - Properties
    var infoItems: [InfoModel] = []
    var navigationToPayment: (() -> Void)?

    @Published var infoState: AlertModel?

    init() {
        observeInfoItems()
    }
    func numberOfItems() -> Int {
        return infoItems.count
    }
    func didTapPlusButton(navigationController: UINavigationController?) {
        // navigate to address screen
        let addressVC = AddAddressViewController(
            viewModel: AddAddressViewModel()
        )
        navigationController?.pushViewController(addressVC, animated: true)
    }
    func didTapPaymentButton() {
        if infoItems.isEmpty {
            self.infoState = AlertModel(
                message: "Info is empty, Please add at least one piece of information.",
                buttonTitle: "Ok",
                image: .warning,
                status: .warning)
        } else {
            /// Show Credit
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
