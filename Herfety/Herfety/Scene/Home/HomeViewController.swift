//
//  HomeViewController.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 04/02/2025.
//

import UIKit

protocol CollectionViewProvider {
    func registerCells(in collectionView: UICollectionView)
    var numberOfItems: Int { get }
    func cellForItems(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
}
protocol HeaderAndFooterProvider {
    func cellForItems(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
}
protocol SectionLayoutProvider {
    func layoutSection() -> NSCollectionLayoutSection
}

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    //
    private var navigationBarBehavior: HomeNavBar?
    private let viewModel = HomeViewModel()
    private var sections: [CollectionViewProvider] = []
    private var layoutProviders:[SectionLayoutProvider] = []
    
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
    }
    
    // Configure Provider
    //
    private func configureSections() {
        let sliderProvider = SliderCollectionViewSection(sliderItems: viewModel.sliderItems)
        let categorProvider = CategoryCollectionViewSection(categoryItems: viewModel.categoryItems)
        let cardProvider = CardItemCollectionViewSection(productItems: viewModel.productItems)
        let topBrands = TopBrandsCollectionViewSection(topBrandsItems: viewModel.topBrandsItems)
        let dailyEssentailItems = DailyEssentailCollectionViewSection(dailyEssentail: viewModel.dailyEssentailItems)
        sections = [sliderProvider, categorProvider, cardProvider, topBrands, dailyEssentailItems]
        
        layoutProviders.append(SliderSectionLayoutProvider())
        layoutProviders.append(CategoriesSectionLayoutSection())
        layoutProviders.append(CardProductSectionLayoutProvider())
        layoutProviders.append(TopBrandsSectionLayoutProvider())
        layoutProviders.append(DailyEssentailSectionLayoutProvider())
    }
    
    func configureNavBar() {
        navigationBarBehavior = HomeNavBar(navigationItem: navigationItem)
        navigationBarBehavior?.configure(onNotification: {
            print("searchBtn is tapped")
        }, onSearch: {
            print("NotificationBtn is tapped")
        },userName: "Mahmoud Alaa", userImage: Images.profilePhoto)
    }
    
    private func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        /// Registere cells
        sections.forEach { $0.registerCells(in: collectionView) }
    }
}

// MARK: - Configure Layout
//
extension HomeViewController {
    private func cofigureCompositianalLayout() {

        let layoutFactory = SectionsLayout(providers: layoutProviders)
        self.collectionView.setCollectionViewLayout(layoutFactory.createLayout(), animated: true)
    }
}

// MARK: - UICollectionViewDelegate
//
extension HomeViewController: UICollectionViewDelegate {}
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
