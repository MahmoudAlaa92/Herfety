//
//  ShippingViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 13/02/2025.
//

import UIKit

class ShippingViewModel {
    
    var shippingItems: [ShippingModel] = [
        ShippingModel(name: "Mahmoud", address: "Aswan", phone: "01142128919"),
        ShippingModel(name: "Mahmoud", address: "Aswan", phone: "01142128919"),
        ShippingModel(name: "Mahmoud", address: "Aswan", phone: "01142128919"),
        ShippingModel(name: "Mahmoud", address: "Aswan", phone: "01142128919"),
    ]
    
    func numberOfItems() -> Int {
        return shippingItems.count
    }
    
    var navigationToPayment: (()-> Void)?
    
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
