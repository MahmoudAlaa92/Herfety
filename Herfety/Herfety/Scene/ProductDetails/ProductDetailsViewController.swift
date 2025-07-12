import Combine
//
//  ProductDetailsViewController.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 27/02/2025.
//
import UIKit

class ProductDetailsViewController: UIViewController {
    // MARK: - Properties
    //
    @IBOutlet weak var collectionView: UICollectionView!
    ///
    private(set) var viewModel: ProductDetailsViewModel
    private var sections: [CollectionViewDataSource] = []
    private var layoutSections: [LayoutSectionProvider] = []
    private var navBarBehavior: HerfetyNavigationController?
    private var productDetialsSection: ProductDetailsCollectionViewSection?
    private var reviewDetailsSection: ReviewCollectionViewSection?
    private var recommendedProductsSection: CardItemCollectionViewSection?
    ///
    private var subscriptions = Set<AnyCancellable>()
    weak var coordinator: PoroductsDetailsTransitionDelegate?
    weak var alertPresenter: AlertPresenter?
    // MARK: - Init
    init(viewModel: ProductDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        setUpCollectionView()
        configureSections()
        configureLayoutSections()
        bindViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        viewModel.loadReviews()
    }
}
// MARK: - Configuration
//
extension ProductDetailsViewController {
    /// NavBar
    private func setUpNavigationBar() {
        navBarBehavior = HerfetyNavigationController(
            navigationItem: navigationItem,
            navigationController: navigationController
        )
        navBarBehavior?.configure(
            title: "",
            titleColor: Colors.primaryBlue,
            onPlus: {
                /// don't add plus button in VC
            },
            showRighBtn: false,
            showBackButton: true,  // Enable back button
            onBack: { [weak self] in
                self?.coordinator?.backToProductsVC()
                self?.coordinator?.backToHomeVC()
            }
        )
    }
    /// CollectoinView
    private func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    /// Sections
    private func configureSections() {
        let productDetials = ProductDetailsCollectionViewSection(
            productItems: viewModel.productItem
        )
        self.productDetialsSection = productDetials

        let reviews = ReviewCollectionViewSection(
            reviewItems: viewModel.reviews,
            rating: viewModel.productItem
        )
        self.reviewDetailsSection = reviews

        let recommendItems = CardItemCollectionViewSection(
            productItems: viewModel.recommendItems
        )
        self.recommendedProductsSection = recommendItems

        recommendItems.headerConfigurator = { header in
            header.configure(
                title: "Recommended for you",
                description: "",
                shouldShowButton: false
            )
        }
        sections = [productDetials, reviews, recommendItems]

        sections.forEach({ $0.registerCells(in: collectionView) })
    }
    /// Layout
    private func configureLayoutSections() {
        let productImages = ProductDetailsCollectionViewProvider()
        let review = ReviewCollectionViewSectionLayout()
        let recommendItems = CardProductSectionLayoutProvider()

        layoutSections = [productImages, review, recommendItems]

        let layoutFactory = SectionsLayout(providers: layoutSections)
        collectionView.setCollectionViewLayout(
            layoutFactory.createLayout(),
            animated: true
        )
    }
}
// MARK: - UICollectionViewDataSource
//
extension ProductDetailsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        sections[section].numberOfItems
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        sections[indexPath.section].cellForItems(
            collectionView,
            cellForItemAt: indexPath
        )
    }

    // Header And Footer
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {

        if let provider = sections[indexPath.section]
            as? HeaderAndFooterProvider
        {
            return provider.cellForItems(
                collectionView,
                viewForSupplementaryElementOfKind: kind,
                at: indexPath
            )
        }

        return UICollectionReusableView()
    }
}
// MARK: - UICollectionViewDelegate
//
extension ProductDetailsViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        if let selectable = sections[indexPath.section]
            as? CollectionViewDelegate
        {
            selectable.collectionView(
                collectionView,
                didSelectItemAt: indexPath
            )
        }
    }
}
// MARK: - Binding ViewModel
//
extension ProductDetailsViewController {
    func bindViewModel() {

        viewModel.$productItem.sink { _ in
            self.collectionView.reloadData()
        }.store(in: &subscriptions)

        /// recommended items
        viewModel.$recommendItems
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newItems in
                self?.recommendedProductsSection?.productItems = newItems
                self?.collectionView.reloadData()
            }.store(in: &subscriptions)
        /// selected her
        recommendedProductsSection?.selectedItem.sink(receiveValue: {
            [weak self] value in
            self?.coordinator?.goToProductDetailsVC(productDetails: value)
        }).store(in: &subscriptions)

        bindWishlist()
        bindReviewrs()
        bindUpadateReviews()
    }
    // MARK: - Wishlist
    private func bindWishlist() {
        CustomeTabBarViewModel.shared.$Wishlist
            .dropFirst()
            .sink { [weak self] wishlist in
                guard let self = self else { return }

                /// Trigger alert presentation
                let alertItem = AlertModel(
                    message: "Added To Wishlist",
                    buttonTitle: "Ok",
                    image: .success,
                    status: .success
                )
                self.alertPresenter?.showAlert(alertItem)
            }
            .store(in: &subscriptions)
    }
    // MARK: - Reviewrs
    private func bindReviewrs() {
        reviewDetailsSection?.reviewrsButton.sink { [weak self] reviewrs in
            
            guard let self = self else { return }
            
            self.coordinator?.goToReviewersVC(productId: viewModel.currentProductId, reviewers: reviewrs)
        }.store(in: &subscriptions)
    }
    /// Reviews Updated
    private func bindUpadateReviews() {
        viewModel.onReviewsUpdated = { [weak self] in

            guard let self = self else { return }

            self.reviewDetailsSection?.reviewItems = self.viewModel.reviews

            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}
