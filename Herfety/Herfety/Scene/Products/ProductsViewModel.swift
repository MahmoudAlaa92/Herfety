//
//  ProductsViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 22/02/2025.
//
import UIKit
import Combine

@MainActor
final class ProductsViewModel {
    // MARK: - Properties
    /// Inputs
    @Published var productItems: [Products] = []
    var onProdcutsDetials = PassthroughSubject<Wishlist, Never>()
    /// Outputs
    @Published private(set) var sections: [CollectionViewDataSource] = []
    @Published private(set) var layoutSections: [LayoutSectionProvider] = []
    ///
    private var cancellabels = Set<AnyCancellable>()
    ///
    private let categoryRemote: GetProductsOfCatergoryRemoteProtocol
    private let offerRemote: OfferRemoteProtocol
    // MARK: - Init
    init(
        categoryRemote: GetProductsOfCatergoryRemoteProtocol = GetProductsOfCategoryRemote(network: AlamofireNetwork()),
        offerRemote: OfferRemoteProtocol = OfferRemote(network: AlamofireNetwork())
    ) {
        self.categoryRemote = categoryRemote
        self.offerRemote = offerRemote
        configureSections()
        configureLayoutSections()
    }}
// MARK: - Private Handler
//
extension ProductsViewModel {
    private func configureSections() {
        let products = ProductsCollectionViewSection(Products: self.productItems)
        products
            .selectedItem
            .sink { [weak self] products in
                self?.onProdcutsDetials.send(products)
            }
            .store(in: &cancellabels)
        
        sections = [products]
    }
    private func configureLayoutSections() {
        layoutSections = [ProductsCollectionViewSectionLayout()]
    }
}
// MARK: - Handle Networking
//
extension ProductsViewModel {
    /// Products of SliderItems & DailyEssential (10% to 80%)
    func fetchProductItems(discount: Int) {
        Task {
            do {
                let offers = try await offerRemote.loadSpecificOffer(disount: discount)
                self.productItems = offers
                configureSections()
            } catch {
                assertionFailure("Error retrieving productItems: \(error)")
            }
        }
    }
    /// Products of Categories
    func fetchProductItems(nameOfCategory: String) {
        Task {
            do {
                let products = try await categoryRemote.loadAllProducts(name: nameOfCategory)
                self.productItems = products
                configureSections()
            } catch {
                print("Error fetching category products:", error)
            }
        }
    }
    /// Serch about Products of Categories
    func searchProducts(with keyword: String) {
        Task {
            do {
                let filteredProducts = try await categoryRemote.loadAllProducts(name: keyword)
                self.productItems = filteredProducts
                configureSections()
            } catch {
                print("Search Error:", error)
            }
        }
    }
}
