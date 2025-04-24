//
//  ProductDetailsViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 27/02/2025.
//

import Foundation

class ProductDetailsViewModel {
    @Published var productItem: Products = Products()
    
    @Published var reviewsItems: [Review] = [
        Review(comment: "This Is Good", image: Images.profilePhoto),
        Review(comment: "This Is Good", image: Images.profilePhoto)
    ]
    
   @Published  var recommendItems: [Products] = []
}
// MARK: - Handlers
extension ProductDetailsViewModel {
    func fetchProductItems() {
        let ProductsRemote: ProductsRemoteProtocol = ProductsRemote(network: AlamofireNetwork())
        ProductsRemote.loadAllProducts { [weak self] result in
            switch result {
            case .success(let Products):
                DispatchQueue.main.async {
                    self?.recommendItems = Products
                }
            case .failure(let error):
                assertionFailure("Error when fetching categories: \(error)")
            }
        }
    }
}
