//
//  HomeViewController.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 04/02/2025.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    //
    private var navigationBarBehavior: HomeNavBar?
    private(set) var viewModel = HomeViewModel()
    private var sections: [CollectionViewDataSource] = []
    private var layoutSections:[LayoutSectionProvider] = []
    
    private var sliderItem: SliderCollectionViewSection?
    private var categoryItem: CategoryCollectionViewSection?
    private var cardItem: CardItemCollectionViewSection?
    private var topBrandItem: TopBrandsCollectionViewSection?
    private var dailyEssentialItem: DailyEssentailCollectionViewSection?
    ///
    private var subscriptions = Set<AnyCancellable>()
    // MARK: - Outlets
    //
    @IBOutlet weak var collectionView: UICollectionView!
    // MARK: - Lifecycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSections()
        setUpCollectionView()
        cofigureCompositianalLayout()
        configureNavBar()
        bindViewModel()
    }
    
    private func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        /// Registere cells
        sections.forEach { $0.registerCells(in: collectionView) }
    }
}

// MARK: - Configuration
//
extension HomeViewController {
    
    /// Configure Sections
    private func configureSections() {
        let sliderProvider = SliderCollectionViewSection(sliderItems: viewModel.sliderItems)
        self.sliderItem = sliderProvider
        
        let categoryProvider = CategoryCollectionViewSection(categoryItems: viewModel.categoryItems)
        self.categoryItem = categoryProvider

        let cardProvider = CardItemCollectionViewSection(productItems: viewModel.productItems)
        self.cardItem = cardProvider
        cardProvider.headerConfigurator = { header in
            header.configure(title: "the best deal on", description: "Jewelry & Accessories", shouldShowButton: true)
        }

        let topBrands = TopBrandsCollectionViewSection(topBrandsItems: viewModel.topBrandsItems)
        self.topBrandItem = topBrands

        let dailyEssentials = DailyEssentailCollectionViewSection(dailyEssentail: viewModel.dailyEssentailItems)
        self.dailyEssentialItem = dailyEssentials

        sections = [sliderProvider, categoryProvider, cardProvider, topBrands, dailyEssentials]

        layoutSections = [
            SliderSectionLayoutProvider(),
            CategoriesSectionLayoutSection(),
            CardProductSectionLayoutProvider(),
            TopBrandsSectionLayoutProvider(),
            DailyEssentailSectionLayoutProvider()
        ]
    }
    /// NavBar
    func configureNavBar() {
        navigationBarBehavior = HomeNavBar(navigationItem: navigationItem)
        navigationBarBehavior?.configure(onNotification: {
            print("searchBtn is tapped")
        }, onSearch: {
            print("NotificationBtn is tapped")
        },userName: "Mahmoud Alaa", userImage: Images.profilePhoto)
    }
    /// CompositianalLayout
    private func cofigureCompositianalLayout() {
        
        let layoutFactory = SectionsLayout(providers: layoutSections)
        self.collectionView.setCollectionViewLayout(layoutFactory.createLayout(), animated: true)
    }
}
// MARK: - UICollectionViewDelegate
//
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectable = sections[indexPath.section] as? CollectionViewDelegate {
            selectable.collectionView(collectionView, didSelectItemAt: indexPath)
        }
    }
}
// MARK: - UICollectionViewDataSource
//
extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].numberOfItems
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return sections[indexPath.section].cellForItems(collectionView, cellForItemAt: indexPath)
    }
    // MARK: - Header And Footer
    //
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if let provider = sections[indexPath.section] as? HeaderAndFooterProvider {
            return provider.cellForItems(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath)
        }
        /// provider does not support headers/footers.
        return UICollectionReusableView()
    }
}
// MARK: - Binding ViewModel
//
extension HomeViewController {
    private func bindViewModel() {
        bindSliderItems()
        bindCategoryItems()
        bindProductItems()
        bindTopBrandsItems()
        bindDailyEssentialsItems()
    }
    // MARK: - Slider Items
    private func bindSliderItems() {
        viewModel
            .$sliderItems
            .sink { [weak self] _ in
                self?.collectionView.reloadData()
            }.store(in: &subscriptions)
        ///
        sliderItem?.selectedItem.sink { [weak self] sliderItem in
            let vc = ProductsViewController(viewModel: ProductsViewModel())
            self?.navigationController?.pushViewController(vc, animated: true)
        }.store(in: &subscriptions)
    }
    // MARK: - Category Items
    private func bindCategoryItems() {
        viewModel.$categoryItems
            .sink { [weak self] _ in
                self?.collectionView.reloadData()
            }
            .store(in: &subscriptions)
        ///
        categoryItem?.categorySelection.sink { [weak self] value in
            let vc = ProductsViewController(viewModel: ProductsViewModel())
            self?.navigationController?.pushViewController(vc, animated: true)
        }.store(in: &subscriptions)
    }
    // MARK: - Product Items
    private func bindProductItems() {
        viewModel.$productItems
            .sink { [weak self] _ in
                self?.collectionView.reloadData()
            }
            .store(in: &subscriptions)
        ///
        cardItem?.selectedItem.sink(receiveValue: { [weak self] value in
            let vc = ProductDetailsViewController(viewModel: ProductDetailsViewModel())
            self?.navigationController?.pushViewController(vc, animated: true)
        }).store(in: &subscriptions)
    }
    // MARK: - Top Brands
    private func bindTopBrandsItems() {
        viewModel.$topBrandsItems
            .sink { [weak self] _ in
                self?.collectionView.reloadData()
            }
            .store(in: &subscriptions)
        ///
        topBrandItem?.selectedBrand.sink(receiveValue: { [weak self] value in
            let vc = ProductsViewController(viewModel: ProductsViewModel())
            self?.navigationController?.pushViewController(vc, animated: true)
        }).store(in: &subscriptions)
    }
    // MARK: - Daily Essentials
    private func bindDailyEssentialsItems() {
        viewModel.$dailyEssentailItems
            .sink { [weak self] _ in
                self?.collectionView.reloadData()
            }
            .store(in: &subscriptions)
        ///
        dailyEssentialItem?.selectedItem.sink(receiveValue: { [weak self] value in
            let vc = ProductsViewController(viewModel: ProductsViewModel())
            self?.navigationController?.pushViewController(vc, animated: true)
        }).store(in: &subscriptions)
    }
}
