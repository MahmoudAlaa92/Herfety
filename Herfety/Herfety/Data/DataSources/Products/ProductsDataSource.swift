//
//  ProductsDataSource.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 17/08/2025.
//

import Foundation

class ProductsDataSource: ProductsDataSourceProtocol {
    
    private let categoryRemote: GetProductsOfCatergoryRemoteProtocol
    private let ProductsRemote: OfferRemoteProtocol
    
    init(categoryRemote: GetProductsOfCatergoryRemoteProtocol, ProcutsRemote: OfferRemoteProtocol) {
        self.categoryRemote = categoryRemote
        self.ProductsRemote = ProcutsRemote
    }
    
    func fetchProductsOfCategory(discount: Int) async throws -> [Products] {
        return try await ProductsRemote.loadSpecificOffer(disount: discount)
    }
    
    func fetchWhileSearch(name: String) async throws -> [Products] {
        return try await categoryRemote.loadAllProducts(name: name)
    }
}
