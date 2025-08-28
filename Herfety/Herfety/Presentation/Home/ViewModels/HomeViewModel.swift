//
//  HomeViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 04/02/2025.
//
import UIKit
import Combine

class HomeViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var categoryItems: [CategoryElement] = []
    @Published var productItems: [Products] = []
    @Published var showAlert: AlertModel?
    @Published private(set) var sections: [CollectionViewDataSource] = []
    @Published private(set) var layoutSections: [LayoutSectionProvider] = []
    
    // MARK: - Static Data
    let sliderItems = HomeStaticDataProvider.createSliderItems()
    let topBrandsItems = HomeStaticDataProvider.createTopBrandsItems()
    let dailyEssentialItems = HomeStaticDataProvider.createDailyEssentialItems()
    
    // MARK: - Dependencies
    private let dataSource: HomeDataSourceProtocol
    private let alertService: AlertServiceProtocol
    private let sectionConfigurator: HomeSectionConfiguratorProtocol
    private weak var coordinator: HomeTranisitionProtocol?
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    init(
        dataSource: HomeDataSourceProtocol,
        alertService: AlertServiceProtocol,
        sectionConfigurator: HomeSectionConfiguratorProtocol,
        coordinator: HomeTranisitionProtocol
    ) {
        self.dataSource = dataSource
        self.alertService = alertService
        self.sectionConfigurator = sectionConfigurator
        self.coordinator = coordinator
        
        setupAlertObserver()
        configureSectionsAndLayouts()
    }
}
// MARK: - Public Methods
//
extension HomeViewModel {
    func numberOfSections() -> Int {
        return HomeSection.allCases.count
    }
    
    func numberOfItems(in section: Int) -> Int {
        switch HomeSection(rawValue: section) {
        case .slider: return sliderItems.count
        case .categories: return categoryItems.count
        case .products: return productItems.count
        case .dailyEssentials: return dailyEssentialItems.count
        case .none: return 0
        }
    }
    
    func fetchData() async {
        await withTaskGroup(of: Void.self) { group in
            group.addTask { await self.fetchCategories() }
            group.addTask { await self.fetchProducts() }
        }
    }
    
    func configureSectionsAndLayouts() {
        guard let coordinator = coordinator else { return }
        
        sections = sectionConfigurator.configureSections(
            sliderItems: sliderItems,
            categoryItems: categoryItems,
            productItems: productItems,
            topBrandsItems: topBrandsItems,
            dailyEssentialItems: dailyEssentialItems,
            coordinator: coordinator
        )
        
        layoutSections = sectionConfigurator.configureLayoutSections()
    }
}
// MARK: - Private Methods
//
extension HomeViewModel {
    private func setupAlertObserver() {
        alertService.alertPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.showAlert, on: self)
            .store(in: &cancellables)
    }
    
    private func fetchCategories() async {
        do {
            let categories = try await dataSource.fetchCategories()
            await MainActor.run { self.categoryItems = categories }
        } catch {
            print("Error when fetching categories: \(error)")
        }
    }
    
    private func fetchProducts() async {
        do {
            let products = try await dataSource.fetchProducts()
            await MainActor.run { self.productItems = products }
        } catch {
            print("Error when fetching products: \(error)")
        }
    }
}

