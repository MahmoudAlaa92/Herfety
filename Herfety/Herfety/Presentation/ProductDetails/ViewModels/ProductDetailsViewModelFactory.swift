//
//  ProductDetailsViewModelFactory.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 22/08/2025.
//

import Foundation

class ProductDetailsViewModelFactory {
    static func creat(coordinator: PoroductsDetailsTransitionDelegate,
                      currentProductId: Int,
                      productItem: Wishlist) -> ProductDetailsViewModel {
        let reviewRemote = ReviewRemote(network: AlamofireNetwork())
        let recommendedRemote = ProductsRemote(network: AlamofireNetwork())
        let dataSource = ProductDetailsDataSource(reviewsRemote: reviewRemote,
                                                  recommendedProdcutsRemote: recommendedRemote)
        let sectionConfigurator = ProductDetailsSectionConfigurator()
        
        return ProductDetailsViewModel(
            dataSource: dataSource,
            sectionConfigurator: sectionConfigurator,
            currentProductId: currentProductId,
            coordinator: coordinator,
            productItem: productItem)
    }
}
