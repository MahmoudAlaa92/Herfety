//
//  ProdcutsViewModelFactory.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 17/08/2025.
//

import Foundation

struct ProdcutsViewModelFactory {
    func create(coordinator: ProductsTransitionDelegate) -> ProductsViewModel {
        let productsRemote: OfferRemoteProtocol = OfferRemote(network: AlamofireNetwork())
        let categoryRemote: GetProductsOfCatergoryRemoteProtocol = GetProductsOfCategoryRemote(network: AlamofireNetwork())
        
        let dataSource = ProductsDataSource(categoryRemote: categoryRemote,
                                            ProcutsRemote: productsRemote)
        let sectionConfigurator = ProductsSectionConfigurator()

        return ProductsViewModel(
            dataSource: dataSource,
            sectionConfigurator: sectionConfigurator,
            coordinator: coordinator
        )
    }
}
