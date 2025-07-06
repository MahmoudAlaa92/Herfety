//
//  ProductsViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 22/02/2025.
//
import UIKit
import Combine

class ProductsViewModel {
    // MARK: - Properties
    @Published var productItems: [Products] = []
    private let categoryRemote: GetProductsOfCatergoryRemoteProtocol
    
    init(
        categoryRemote: GetProductsOfCatergoryRemoteProtocol = GetProductsOfCategoryRemote(network: AlamofireNetwork())
    ) {
        self.categoryRemote = categoryRemote
    }
}
// MARK: - Handlers
//
extension ProductsViewModel {
    // MARK: Products of SliderItems & DailyEssential (10% to 80%)
    func fetchProductItems(discount: Int) {
        let productItems: OfferRemoteProtocol = OfferRemote(network: AlamofireNetwork())
        productItems.loadSpecificOffer(disount: discount) { [weak self] result in
            switch result {
            case .success(let offers):
                    self?.productItems = offers
            case .failure(let error):
                assertionFailure("Error when reteive productIetms in ProductsViewModel \(error)")
            }
        }
    }
    // MARK: Products of Categories
    func fetchProductItems(nameOfCategory: String) {
        let productItems: GetProductsOfCategoryRemote = GetProductsOfCategoryRemote(network: AlamofireNetwork())
        productItems.loadAllProducts(name: nameOfCategory) { result in
            switch result {
            case.success(let products):
                DispatchQueue.main.async {
                    self.productItems = products
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    // MARK: Serch about Products of Categories
    func searchProducts(with keyword: String) {
        categoryRemote.loadAllProducts(name: keyword) { [weak self] result in
            switch result {
            case .success(let filteredProducts):
                DispatchQueue.main.async {
                    self?.productItems = filteredProducts
                }
            case .failure(let error):
                print("Search Error:", error)
            }
        }
    }
}
