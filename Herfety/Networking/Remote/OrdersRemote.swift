//
//  OrdersRemote.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 05/05/2025.
//

import Foundation


struct Orderr : Decodable {
    let companyDeliveryId: Int
    let userId: Int
    let currencyName: Int
    let paymentMethod: Int
    let orderAddress: String
    let subTotal: Double
    let orderStatus: Int
    let productsOrder: [ProductIntent]
    let createdAt: String
    let updatedAt: String
}

struct ProductOrderr: Decodable {
    let vendorId: Int
    let productId: Int
    let quantity: Int
}


protocol OrderRemoteProtocol {
    func loadAllOrders(completion: @escaping (Result<[Orderr], Error>) -> Void)
    func addOrder(order: Orderr, completion: @escaping (Result<RecieveOrders, Error>) -> Void)
}

class GetAllOrdersRemote: Remote, OrderRemoteProtocol, @unchecked Sendable {
    
    /// .GET all orders
    func loadAllOrders(completion: @escaping (Result<[Orderr], Error>) -> Void) {
        let request = HerfetyRequest(
            method: .get,
            path: "api/Orders"
        )
        enqueue(request, completion: completion)
    }
    
    /// .POST create new order
    func addOrder(order: Orderr, completion: @escaping (Result<RecieveOrders, Error>) -> Void) {
        let productOrders: [[String: Any]] = order.productsOrder.map { product in
            return [
                "vendorId": product.vendorID,
                "productId": product.productID,
                "quantity": product.quantity
            ]
        }

        let parameters: [String: Any] = [
            "companyDeliveryId": order.companyDeliveryId,
            "userId": order.userId,
            "currencyName": order.currencyName,
            "paymentMethod": order.paymentMethod,
            "orderAddress": order.orderAddress,
            "subTotal": order.subTotal,
            "orderStatus": order.orderStatus,
            "productsOrder": productOrders,
            "createdAt": order.createdAt,
            "updatedAt": order.updatedAt
        ]
        
        let request = HerfetyRequest(
            method: .post,
            path: "api/Orders",
            parameters: parameters,
            destination: .body
        )
        
        enqueue(request, completion: completion)
    }
}
