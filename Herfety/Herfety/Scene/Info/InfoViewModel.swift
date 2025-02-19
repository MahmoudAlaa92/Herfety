//
//  ShippingViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 13/02/2025.
//

import UIKit

class InfoViewModel {
    
    var shippingItems: [InfoModel] = [
        InfoModel(name: "Mahmoud", address: "Aswan", phone: "01142128919"),
        InfoModel(name: "Mahmoud", address: "Aswan", phone: "01142128919"),
        InfoModel(name: "Mahmoud", address: "Aswan", phone: "01142128919"),
        InfoModel(name: "Mahmoud", address: "Aswan", phone: "01142128919"),
    ]
    
    func numberOfItems() -> Int {
        return shippingItems.count
    }
    
    var navigationToPayment: (()-> Void)?
    
    func didTapPlusButton() {
        // navigate to address screen here
    }
    
    func didTapPaymentButton() {
        if shippingItems.isEmpty {
            // Show Alert of Warning
            print("Show Alert Warning")
        }else{
            // Show Credit
            navigationToPayment?()
        }
    }
}
