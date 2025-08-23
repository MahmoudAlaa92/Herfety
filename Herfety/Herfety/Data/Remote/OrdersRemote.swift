//
//  OrdersRemote.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 05/05/2025.
//

import Foundation

protocol OrderRemoteProtocol {
    /// Async/await versions
    func loadAllOrders() async throws -> [OrderDeliveryItem]
    func addOrder(order: OrderDeliveryItem) async throws -> RecieveOrders
    /// Legacy callback versions for backward compatibility
    func loadAllOrders(completion: @escaping (Result<[OrderDeliveryItem], Error>) -> Void)
    func addOrder(order: OrderDeliveryItem, completion: @escaping (Result<RecieveOrders, Error>) -> Void)
}

class GetAllOrdersRemote: Remote, OrderRemoteProtocol, @unchecked Sendable {
    
    /// .GET all orders
    func loadAllOrders(completion: @escaping (Result<[OrderDeliveryItem], Error>) -> Void) {
        let request = HerfetyRequest(
            method: .get,
            path: "api/Orders"
        )
        enqueue(request, completion: completion)
    }
    
    /// .POST create new order
    func addOrder(order: OrderDeliveryItem, completion: @escaping (Result<RecieveOrders, Error>) -> Void) {
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
// MARK: - Modern Async/Await Methods
//
extension GetAllOrdersRemote {
    
    func loadAllOrders() async throws -> [OrderDeliveryItem] {
        let request = HerfetyRequest(
            method: .get,
            path: "api/Orders"
        )
        return try await enqueue(request)
    }

    func addOrder(order: OrderDeliveryItem) async throws -> RecieveOrders {
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
        
        return try await enqueue(request)
    }
}
