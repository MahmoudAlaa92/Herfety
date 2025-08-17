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
    private lazy var navBarBehavior = HerfetyNavigationController(
        navigationItem: navigationItem,
        navigationController: navigationController)
    weak var coordinator: ProductsTransitionDelegate?
    ///
    private var cancellabels = Set<AnyCancellable>()
    
    // MARK: - Init
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
        setUpCollectionView()
        bindViewModel()
        searchTextField.addTarget(
            self,
            action: #selector(searchTextChanged(_:)),
            for: .editingChanged)
    }
}
// MARK: - Configuraion
//
extension ProductsViewController {
    /// NavBar
    private func setUpNavigationBar() {
        navBarBehavior.configure(
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
    /// Collection
    private func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    /// Section
    private func configureSections() {
        let factory = SectionsLayout(providers: viewModel.layoutSections)
        collectionView.setCollectionViewLayout(
            factory.createLayout(),
            animated: true
        )
        viewModel.sections.forEach({ $0.registerCells(in: collectionView) })
    }
}
// MARK: - UICollectionViewDataSource
//
extension ProductsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.sections.count
    }
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        viewModel.sections[section].numberOfItems
    }
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        viewModel.sections[indexPath.section].cellForItems(
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
        if let selectable = viewModel.sections[indexPath.section]
            as? CollectionViewDelegate
        {
            selectable.collectionView(
                collectionView,
                didSelectItemAt: indexPath
            )
        }
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
        Task {
            await viewModel.fetchProductsWhileSearch(name: searchText)
        }
    }
}
// MARK: - Binding
//
extension ProductsViewController {
    private func bindViewModel() {
        viewModel
            .$productItems
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.collectionView.reloadData()
            }
            .store(in: &cancellabels)
    }
}
