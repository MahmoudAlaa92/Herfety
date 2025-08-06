//
//  AddAddressViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 17/02/2025.
//

import Foundation
import Combine

class AddAddressViewModel:AddAddressViewModelType {
    
    // MARK: - Subjects
    private let nameSubject = CurrentValueSubject<String, Never>("")
    private let addressSubject = CurrentValueSubject<String, Never>("")
    private let phoneSubject = CurrentValueSubject<String, Never>("")
    private let addTappedSubject = PassthroughSubject<Void, Never>()
    ///
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Outputs
    let isAddButtonEnabled: AnyPublisher<Bool, Never>
    let success = PassthroughSubject<Void, Never>()
    let showAlert = PassthroughSubject<AlertModel, Never>()
    
    weak var coordinator: AddAddressChildDelegate?
    // MARK: - Init
    init() {
        isAddButtonEnabled = Publishers.CombineLatest3(
            nameSubject,
            addressSubject,
            phoneSubject
        )
        .map { !$0.0.isEmpty && !$0.1.isEmpty && !$0.2.isEmpty }
        .eraseToAnyPublisher()
        
        addTappedSubject
            .sink { [weak self] in
                self?.handleAdd()
            }
            .store(in: &cancellables)
    }
}
// MARK: - Inputs
//
extension AddAddressViewModel {
    func updateName(_ text: String) {
        nameSubject.send(text)
    }
    
    func updateAddress(_ text: String) {
        addressSubject.send(text)
    }

    func updatePhone(_ text: String) {
        phoneSubject.send(text)
    }
    
    func addButtonTapped() {
        addTappedSubject.send()
    }
}
// MARK: - Private Handlers
//
extension AddAddressViewModel {
    private func handleAdd() {
        let name = nameSubject.value
        let address = addressSubject.value
        let phone = phoneSubject.value
        
        if name.isEmpty || address.isEmpty || phone.isEmpty {
            let alertItem = AlertModel(
                message: "One of the text fields is empty",
                buttonTitle: "OK",
                image: .warning,
                status: .warning
            )
            showAlert.send(alertItem)
            return
        }
        
        let addressValue = InfoModel(name: name, address: address, phone: phone)
        
        Task {
            let appDataStore =  await AppDataStore.shared
            let isInInfos = await appDataStore.isItemInInfos(addressInfo: addressValue)
            
            if !isInInfos {
                var newInfos = await AppDataStore.shared.infos
                newInfos.append(addressValue)
                await appDataStore.updateInfos(newInfos)
            }
        }
        success.send()
    }
}
