//
//  HomeViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 04/02/2025.
//
import UIKit
import Combine

@MainActor
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
    private weak var coordinator: HomeTranisitionDelegate?
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initialization
    init(
        dataSource: HomeDataSourceProtocol,
        alertService: AlertServiceProtocol,
        sectionConfigurator: HomeSectionConfiguratorProtocol,
        coordinator: HomeTranisitionDelegate
    ) {
        self.dataSource = dataSource
        self.alertService = alertService
        self.sectionConfigurator = sectionConfigurator
        self.coordinator = coordinator
        
        setupAlertObserver()
        configureSectionsAndLayouts()
    }
    
    // MARK: - Public Methods
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
    
    // MARK: - Private Methods
    private func setupAlertObserver() {
        alertService.alertPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.showAlert, on: self)
            .store(in: &cancellables)
    }
    
    private func configureSectionsAndLayouts() {
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
    
    private func fetchCategories() async {
        do {
            categoryItems = try await dataSource.fetchCategories()
            configureSectionsAndLayouts()
        } catch {
            print("Error when fetching categories: \(error)")
        }
    }
    
    private func fetchProducts() async {
        do {
            productItems = try await dataSource.fetchProducts()
            configureSectionsAndLayouts()
        } catch {
            print("Error when fetching products: \(error)")
        }
    }
}
