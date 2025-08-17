//
//  EViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 17/08/2025.
//

import UIKit
import Combine

class ProductsViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var productItems: [Products] = []
    @Published private(set) var sections: [CollectionViewDataSource] = []
    @Published private(set) var layoutSections: [LayoutSectionProvider] = []
    
    // MARK: - Dependencies
    private let dataSource: ProductsDataSourceProtocol
    private let sectionConfigurator: ProductsSectionConfiguratorProtocol
    private weak var coordinator: ProductsTransitionDelegate?
    
    // MARK: - Init
    init(dataSource: ProductsDataSourceProtocol,
         sectionConfigurator: ProductsSectionConfiguratorProtocol,
         coordinator: ProductsTransitionDelegate) {
        self.dataSource = dataSource
        self.sectionConfigurator = sectionConfigurator
        self.coordinator = coordinator
        
        configureSectionsAndLayouts()
    }
}
// MARK: - Public Methods
//
extension ProductsViewModel {
    
    func fetchProductsWhileSearch(name: String) async {
        do {
            productItems = try await dataSource.fetchWhileSearch(name: name)
            configureSectionsAndLayouts()
        } catch {
            print("Error when fetching products: \(error)")
        }
    }
    
    func fetchProducts(discount: Int) async {
        do {
            productItems = try await dataSource.fetchProductsOfCategory(discount: discount)
            configureSectionsAndLayouts()
        } catch {
            print("Error when fetching products: \(error)")
        }
    }
}
// MARK: - Private Methods
//
extension ProductsViewModel {
    private func configureSectionsAndLayouts() {
        guard let coordinator = coordinator else { return }
        
        sections = sectionConfigurator.configureSections(productItems: productItems,
                                                         coordinator: coordinator)
        
        layoutSections = sectionConfigurator.configureLayoutSections()
    }
}
