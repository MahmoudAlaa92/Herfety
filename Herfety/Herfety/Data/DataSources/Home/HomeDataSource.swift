//
//  HomeDataSource.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 16/08/2025.
//

import Foundation

class HomeDataSource: HomeDataSourceProtocol {
    private let categoryRemote: CategoryRemoteProtocol
    private let productsRemote: ProductsRemoteProtocol
    
    init(categoryRemote: CategoryRemoteProtocol, productsRemote: ProductsRemoteProtocol) {
        self.categoryRemote = categoryRemote
        self.productsRemote = productsRemote
    }
    
    func fetchCategories() async throws -> [CategoryElement] {
        return try await categoryRemote.loadAllCategories()
    }
    
    func fetchProducts() async throws -> [Products] {
        return try await productsRemote.loadAllProducts()
    }
}
