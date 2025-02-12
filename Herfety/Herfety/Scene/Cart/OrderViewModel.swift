//
//  OrderViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 11/02/2025.
//

import UIKit
import UIHerfety

class OrderViewModel {
    
    var orderItems: [OrderModel] = [
        OrderModel(name: "Roller Rabbit", description: "Vado Odelle Dress", price: 198.0, image: Images.jewelry, numberOfOrders: 1),
        OrderModel(name: "Roller Rabbit", description: "Vado Odelle Dress", price: 198.0, image: Images.jewelry, numberOfOrders: 1),
        OrderModel(name: "Roller Rabbit", description: "Vado Odelle Dress", price: 198.0, image: Images.jewelry, numberOfOrders: 1),
    ]
    
    /// Computes the payment information from the order items.
    var paymentInfo: PaymentView.Model {
        // Calculate the subtotal
        let subTotal = orderItems.reduce(0.0) { (result, order) -> Double in
            return result + (order.price * Double(order.numberOfOrders))
        }
      
        let shipping: Double = subTotal > 0 ? 10.0 : 0.0
        let total = subTotal + shipping
        let numberOfItems = orderItems.reduce(0) { $0 + $1.numberOfOrders }
        return PaymentView.Model(subTotal: subTotal, shipping: shipping, total: total, numberOfItems: numberOfItems)
    }
    
       
    func numberOfItems(in section: Int) -> Int {
        return orderItems.count
    }
}
