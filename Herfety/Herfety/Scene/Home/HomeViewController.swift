//
//  HomeViewController.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 04/02/2025.
//
import UIKit
import Combine

class HomeViewController: UIViewController {
    
    // MARK: - Outlets
    private var subscriptions = Set<AnyCancellable>()
    // MARK: - Properties
    private var navigationBarBehavior: HomeNavBar?
    private var viewModel = HomeViewModel()
    private var sections: [CollectionViewDataSource] = []
    private var layoutSections:[LayoutSectionProvider] = []
    
    private var sliderItem: SliderCollectionViewSection?
    private var categoryItem: CategoryCollectionViewSection?
    private var cardItem: CardItemCollectionViewSection?
    private var topBrandItem: TopBrandsCollectionViewSection?
    private var dailyEssentialItem: DailyEssentailCollectionViewSection?
    ///
    weak var coordinator: HomeCoordinator?
    weak var alertPresenter: AlertPresenter?
    //
    @IBOutlet weak var collectionView: UICollectionView!
    // MARK: - Lifecycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSections()
        setUpCollectionView()
        cofigureCompositianalLayout()
        bindViewModel()
        Task {
            await configureNavBar()
        }
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
    func configureNavBar() async {
        navigationItem.backButtonTitle = ""
        navigationBarBehavior = HomeNavBar(navigationItem: navigationItem)
        
        let userName = CustomeTabBarViewModel.shared.userInfo?.UserName ?? ""
        let userImageURL = CustomeTabBarViewModel.shared.userInfo?.image
        
        let loadedImage = await UIImage.load(from: userImageURL ?? "")
        
        let finalImage = loadedImage ?? Images.iconPersonalDetails
        CustomeTabBarViewModel.shared.userProfileImage = finalImage
        navigationBarBehavior?.configure(
            onNotification: { [weak self] in
                self?.coordinator?.gotToSafari(url: "https://9ec0-34-74-104-29.ngrok-free.app/")
            },
            onSearch: { [weak self] in
                self?.coordinator?.goToSearchVC(discount: 80)
            },
            userName: userName,
            userImage: finalImage
        )
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
        bindWishlist()
        bindOrders()
    }
    // MARK: - Slider Items
    private func bindSliderItems() {
        viewModel
            .$sliderItems
            .sink { [weak self] _ in
                self?.collectionView.reloadData()
            }.store(in: &subscriptions)
        ///
        sliderItem?.selectedItem.sink { [weak self] sliderItems in
            self?.coordinator?.goToSliderItem(discount: (sliderItems.1+1)*10)
        }.store(in: &subscriptions)
    }
    // MARK: - Category Items
    private func bindCategoryItems() {
        viewModel.fetchCategoryItems()
        viewModel.$categoryItems
            .sink { [weak self] newItems in
                DispatchQueue.main.async {
                    self?.categoryItem?.categoryItems = newItems
                    self?.collectionView.reloadData()
                }
            }
            .store(in: &subscriptions)
        ///
        categoryItem?.categorySelection.sink { [weak self] item in
            self?.coordinator?.goToCategoryItem(category: item.name ?? "")
        }.store(in: &subscriptions)
    }
    // MARK: - Product Items
    private func bindProductItems() {
        viewModel.fetchProductItems()
        viewModel.$productItems
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newItems in
                self?.cardItem?.productItems = newItems
                self?.collectionView.reloadData()
            }
            .store(in: &subscriptions)
        ///
        cardItem?.selectedItem.sink(receiveValue: { [weak self] value in
            self?.coordinator?.gotToBestDealItem(productDetails: value)
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
        topBrandItem?.selectedBrand.sink(receiveValue: { [weak self] items in
            self?.coordinator?.gotToTopBrandItem(discount: (items.1+5)*10)
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
        dailyEssentialItem?.selectedItem.sink(receiveValue: { [weak self] items in
            self?.coordinator?.gotToDailyEssentialItem(discount: (items.1+5)*10)
        }).store(in: &subscriptions)
    }
    // MARK: - Wishlist
    private func bindWishlist() {
        viewModel.$wishlistAlert
            .compactMap { $0 }
            .sink { [weak self] alert in
                self?.alertPresenter?.showAlert(alert)
            }
            .store(in: &subscriptions)
    }
    // MARK: - Orders
    private func bindOrders() {
        viewModel.$orderAlert
            .compactMap { $0 }
            .sink { [weak self] alert in
                self?.alertPresenter?.showAlert(alert)
            }
            .store(in: &subscriptions)
    }
}
