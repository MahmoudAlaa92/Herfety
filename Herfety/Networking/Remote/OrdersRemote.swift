//
//  OrdersRemote.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 05/05/2025.
//

import Foundation

protocol OrderRemoteProtocol {
    func loadAllOrders(completion: @escaping (Result<[Order],Error>) -> Void)
    func AddOrders(order: Order, completion: @escaping (Result<Bool, Error>) -> Void)
    
}
class GetAllOrdersRemote: Remote, OrderRemoteProtocol {
 
    /// .Get
    func loadAllOrders(completion: @escaping (Result<[Order], Error>) -> Void) {
        
        let request = HerfetyRequest(method: .get, path: "api/Orders")
        enqueue(request, completion: completion)
    }
    /// .Post
    func AddOrders(order: Order, completion: @escaping (Result<Bool, Error>) -> Void) {
        let parameter = [
            "companyDeliveryId" : order.companyDeliveryID,
            "orderAddress" : order.orderAddress,
            "subTotal" : order,
            "productsOrder" : order.productsOrder,
            
            "currencyName" : order.currencyName ?? "VISA",
        ] as [String : Sendable]
        let request = HerfetyRequest(method: .post, path: "api/Orders", parameters: parameter)
        enqueue(request, completion: completion)
    }
}
