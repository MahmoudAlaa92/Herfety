//
//  ProductDetailsViewController.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 27/02/2025.
//

import UIKit
import Combine
import ViewAnimator

class ProductDetailsViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    private(set) var viewModel: ProductDetailsViewModel
    private lazy var navBarBehavior = HerfetyNavigationController(
        navigationItem: navigationItem,
        navigationController: navigationController
    )
    ///
    private var cancellabels = Set<AnyCancellable>()
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
        bindViewModel()
    }
}
// MARK: - Configuration
//
extension ProductDetailsViewController {
    /// NavBar
    private func setUpNavigationBar() {
        navBarBehavior.configure(
            title: "",
            titleColor: Colors.primaryBlue,
            onPlus: {
                /// don't add plus button in VC
            },
            showRighBtn: false,
            showBackButton: true,  /// Enable back button
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
        viewModel.sections.forEach({ $0.registerCells(in: collectionView) })
        
        let layoutFactory = SectionsLayout(providers: viewModel.layoutSections)
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
    
    // Header And Footer
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        
        if let provider = viewModel.sections[indexPath.section]
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
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        cell.animate(animations: [AnimationType.from(direction: .bottom, offset: 30)], duration: 0.8)
    }
    
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
// MARK: - Binding ViewModel
//
extension ProductDetailsViewController {
    func bindViewModel() {
        viewModel
            .$sections
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.collectionView.reloadData()
            }
            .store(in: &cancellabels)
    }
}
