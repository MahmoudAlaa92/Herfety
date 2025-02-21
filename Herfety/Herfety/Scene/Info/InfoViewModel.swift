//
//  InfoViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 13/02/2025.
//

import UIKit


class InfoViewModel {
    
    var infoItems: [InfoModel] = [
        InfoModel(name: "Mahmoud", address: "Aswan", phone: "01142128919"),
        InfoModel(name: "Mahmoud", address: "Aswan", phone: "01142128919"),
        InfoModel(name: "Mahmoud", address: "Aswan", phone: "01142128919"),
        InfoModel(name: "Mahmoud", address: "Aswan", phone: "01142128919"),
    ]
    
    func numberOfItems() -> Int {
        return infoItems.count
    }
    
    var navigationToPayment: (()-> Void)?
    
    func didTapPlusButton(navigationController: UINavigationController?) {
        // navigate to address screen
        let addressVC = AddAddressViewController(viewModel: AddAddressViewModel())
        addressVC.delegate = self
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

// MARK: - Delegate
//
extension InfoViewModel: AddAddressViewControllerDelegate {
    func didAddAddress(_ address: InfoModel) {
        self.infoItems.append(address)
        
        NotificationCenter.default.post(name: Notification.Name("infoItemsUpdated"), object: nil)
    }
}
