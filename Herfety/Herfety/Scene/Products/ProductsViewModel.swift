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
                print(products)
                self.productItems = products
            case .failure(let error):
                print(error)
            }
        }
    }
}
