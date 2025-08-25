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
    @Published var infoItems: [InfoModel] = []
    @Published var infoState: AlertModel?
    
    var navigationToPayment: (() -> Void)?
    private var cancellabels = Set<AnyCancellable>()
    
    // MARK: - Collection view sections
    @Published private(set) var sections: [CollectionViewDataSource] = []
    private(set) var layoutProviders: [LayoutSectionProvider] = []
    
    // MARK: - Init
    init() {
        configureLayoutProviders()
        configureSections()
        observeInfoItems()
    }
    
    func didTapPaymentButton() {
        if infoItems.isEmpty {
            self.infoState = AlertModel(
                message: L10n.Info.Error.empty,
                buttonTitle: L10n.General.ok,
                image: .warning,
                status: .warning)
        } else {
            /// Show Credit
            navigationToPayment?()
        }
    }
}
// MARK: - Private Methods
//
extension InfoViewModel {
    private func configureSections() {
        $infoItems
            .sink { [weak self] infoItems in
                guard let self = self else { return }
                
                let infoSection = InfoCollectionViewSection(
                    infoItems: infoItems
                )
                
                self.sections = [infoSection]
                
                infoSection
                    .deleteItemSubject
                    .sink { [weak self] index in
                        self?.deleteItem(at: index)
                    }
                    .store(in: &cancellabels)
            }
            .store(in: &cancellabels)
    }
    
    private func configureLayoutProviders() {
        self.layoutProviders = [InfoSectionLayoutProvider()]
    }
    
    private func observeInfoItems() {
        AppDataStorePublisher
            .shared
            .infoUpdatePublisher
            .sink { [weak self] _ in
                Task {
                    let infoItems = await DataStore.shared.getInfos()
                    self?.infoItems = infoItems
                }
            }.store(in: &cancellabels)
    }
    
    private func deleteItem(at index: Int) {
        Task {
            var items = await DataStore.shared.getInfos()
            guard index < items.count else { return }
            items.remove(at: index)
            await DataStore.shared.updateInfos(items)
        }
    }
}
