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
    private var viewModel = HomeViewModel()
    private var sections: [CollectionViewDataSource] = []
    private var layoutSections:[LayoutSectionProvider] = []
    
    private var sliderItem: SliderCollectionViewSection?
    private var categoryItem: CategoryCollectionViewSection?
    private var cardItem: CardItemCollectionViewSection?
    private var topBrandItem: TopBrandsCollectionViewSection?
    private var dailyEssentialItem: DailyEssentailCollectionViewSection?
    ///
    private var hasInitialWishlistLoaded = false
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
        navigationItem.backButtonTitle = ""
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
            let vc = ProductsViewController(viewModel: ProductsViewModel())
            vc.viewModel.fetchProductItems(discount: (sliderItems.1+1)*10)
            self?.navigationController?.pushViewController(vc, animated: true)
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
            let vc = ProductsViewController(viewModel: ProductsViewModel())
            vc.viewModel.fetchProductItems(nameOfCategory: item.name ?? "")
            self?.navigationController?.pushViewController(vc, animated: true)
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
            #warning("")
            let vc = ProductDetailsViewController(viewModel: ProductDetailsViewModel(productId: value.productID ?? 93))
            vc.viewModel.productItem = value
            vc.viewModel.fetchProductItems()
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
        topBrandItem?.selectedBrand.sink(receiveValue: { [weak self] items in
            let vc = ProductsViewController(viewModel: ProductsViewModel())
            vc.viewModel.fetchProductItems(discount: (items.1+5)*10)
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
        dailyEssentialItem?.selectedItem.sink(receiveValue: { [weak self] items in
            let vc = ProductsViewController(viewModel: ProductsViewModel())
            vc.viewModel.fetchProductItems(discount: (items.1+5)*10)
            self?.navigationController?.pushViewController(vc, animated: true)
        }).store(in: &subscriptions)
    }
    // MARK: - Wishlist
    private func bindWishlist() {
        CustomeTabBarViewModel.shared.$Wishlist
            .dropFirst()
            .sink { [weak self] wishlist in
                guard let self = self else { return }
                /// Skip the first assignment (initial data load)
                if !self.hasInitialWishlistLoaded {
                    self.hasInitialWishlistLoaded = true
                    return
                }
                /// Trigger alert presentation
                let trigger = CustomeTabBarViewModel.shared.isWishlistItemDeleted
                let alertItem = AlertModel(
                    message: trigger == true ?  "Deleted From Wishlist": "Added To Wishlist",
                    buttonTitle: "Ok",
                    image: .success,
                    status: .success
                )
                CustomeTabBarViewModel.shared.isWishlistItemDeleted = false
                self.presentCustomAlert(with: alertItem)
            }
            .store(in: &subscriptions)
    }
    // MARK: - Orders
    private func bindOrders() {
        CustomeTabBarViewModel.shared.$cartItems
            .dropFirst()
            .sink { [weak self] Order in
                guard let self = self else { return }
                /// Trigger alert presentation
                let alertItem = AlertModel(
                    message: "Added To Order",
                    buttonTitle: "Ok",
                    image: .success,
                    status: .success
                )
                self.presentCustomAlert(with: alertItem)
            }
            .store(in: &subscriptions)
    }
}
// MARK: - Private Handler
//
extension HomeViewController {
    func presentCustomAlert(with alertItem: AlertModel) {
        let alertVC = AlertViewController(nibName: "AlertViewController", bundle: nil)
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        alertVC.loadViewIfNeeded() /// Ensure outlets are connected

        alertVC.show(alertItem: alertItem)

        /// Optional: dismiss on button press
        alertVC.actionHandler = { [weak alertVC] in
            alertVC?.dismiss(animated: true)
        }
        self.present(alertVC, animated: true)
    }
}
