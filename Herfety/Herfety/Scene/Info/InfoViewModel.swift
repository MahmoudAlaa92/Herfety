import Combine
//
//  InfoViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 13/02/2025.
//
import UIKit
import Combine

@MainActor
class InfoViewModel {
    // MARK: - Properties
    @Published var infoItems: [InfoModel] = []
    var navigationToPayment: (() -> Void)?
    @Published var infoState: AlertModel?
    var subscription = Set<AnyCancellable>()

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
        AppDataStorePublisher
            .shared
            .infoUpdatePublisher
            .sink { [weak self] _ in
                Task {
                    let infoItems = await DataStore.shared.getInfos()
                    self?.infoItems = infoItems
                }
            }.store(in: &subscription)
    }
    
    func deleteItem(at index: Int) {
        Task {
            var items = await DataStore.shared.getInfos()
            guard index < items.count else { return }
            items.remove(at: index)
            await DataStore.shared.updateInfos(items)
        }
    }

}
