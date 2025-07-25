//
//  ProductsViewController.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 22/02/2025.
//

import Combine
import UIKit

class ProductsViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchTextField: SearchTextField!
    // MARK: - Properties
    private(set) var viewModel: ProductsViewModel
    private var sections = [CollectionViewDataSource]()
    private var layoutSections = [LayoutSectionProvider]()
    private var navBarBehavior: HerfetyNavigationController?
    private var productsItems: ProductsCollectionViewSection?
    ///
    var subscriptions = Set<AnyCancellable>()
    weak var coordinator: ProductsTransitionDelegate?
    // MARK: Init
    init(viewModel: ProductsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        configureSections()
        configureLayout()
        setUpCollectionView()
        bindViewModel()
        searchTextField.addTarget(
            self,
            action: #selector(searchTextChanged(_:)),
            for: .editingChanged
        )
    }
}
// MARK: - Configuraion
//
extension ProductsViewController {
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
                /// don't add plus button in loginVC
            },
            showRighBtn: false,
            showBackButton: true,
            onBack: { [weak self] in
                self?.coordinator?.backToHomeVC()
            }
        )
    }
    /// Section
    private func configureSections() {
        let products = ProductsCollectionViewSection(
            Products: viewModel.productItems
        )
        self.productsItems = products
        sections = [products]
        products.selectedItem.sink { [weak self] products in
            self?.coordinator?.goToProductDetails(productDetails: products)
        }.store(in: &subscriptions)
        layoutSections.append(ProductsCollectionViewSectionLayout())
    }
    /// Layout
    private func configureLayout() {
        let factory = SectionsLayout(providers: layoutSections)
        collectionView.setCollectionViewLayout(
            factory.createLayout(),
            animated: true
        )
    }
    /// Collection
    private func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        sections.forEach({ $0.registerCells(in: collectionView) })
    }
}
// MARK: - UICollectionViewDataSource
//
extension ProductsViewController: UICollectionViewDataSource {
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
}
// MARK: - UICollectionViewDelegate
//
extension ProductsViewController: UICollectionViewDelegate {
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
// MARK: - BindingViewModel
//
extension ProductsViewController {
    private func bindViewModel() {
        viewModel.$productItems
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newItems in
                self?.productsItems?.Products = newItems
                self?.collectionView.reloadData()
            }.store(in: &subscriptions)
    }
}
// MARK: - Actions
//
extension ProductsViewController {
    @objc private func searchTextChanged(_ textField: UITextField) {
        guard
            let searchText = textField.text?.trimmingCharacters(
                in: .whitespacesAndNewlines
            ), !searchText.isEmpty
        else {
            return
        }
        viewModel.searchProducts(with: searchText)
    }
}
