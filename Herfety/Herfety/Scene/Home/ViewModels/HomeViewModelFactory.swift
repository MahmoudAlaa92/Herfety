//
//  HomeViewModelFactory.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 16/08/2025.
//

import Foundation
@MainActor
struct HomeViewModelFactory {
    static func create(coordinator: HomeTranisitionDelegate) -> HomeViewModel {
        let categoryRemote = CategoryRemote(network: AlamofireNetwork())
        let productsRemote = ProductsRemote(network: AlamofireNetwork())
        let dataSource = HomeDataSource(categoryRemote: categoryRemote,
                                        productsRemote: productsRemote)
        let alertService = HomeAlertService(publisherManager: AppDataStorePublisher.shared)
        let sectionConfigurator = HomeSectionConfigurator()
        
        return HomeViewModel(
            dataSource: dataSource,
            alertService: alertService,
            sectionConfigurator: sectionConfigurator,
            coordinator: coordinator
        )
    }
}
