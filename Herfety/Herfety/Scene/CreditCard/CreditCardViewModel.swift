//
//  CreditCardViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 21/02/2025.
//

import UIKit

class CreditCardViewModel {
    
    var onCardNumberChange: ((String) -> Void)?
    var onCardHolderChange: ((String) -> Void)?
    var onCVVChange: ((String) -> Void)?
    var onExpDateChange: ((String) -> Void)?
    var onShowAlert: ((AlertModel) -> Void)?
    var onDismiss: (() -> Void)?
    
    func formatExpirationDate(_ input: String) -> String {
        var input = isValidTextField(value: input, 4)
        
        if input.count > 2 {
            let index = input.index(input.startIndex, offsetBy: 2)
            input.insert("/", at: index)
        }
        return input
    }
    
    func isValidTextField(value: String, _ byPrefix: Int) -> String {
        let numericalValue = value.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        return String(numericalValue.prefix(byPrefix))
    }
    
    func didTapAddCard() {
       
    }
    
    func didTapCancel() {
        onDismiss?()
    }
    
}
