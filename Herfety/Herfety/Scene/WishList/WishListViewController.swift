//
//  WishListViewController.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 09/02/2025.
//

import UIKit
import Combine

class WishListViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    private lazy var navigationBarBehavior = HerfetyNavigationController(
        navigationItem: navigationItem,
        navigationController: navigationController)
    private(set) var viewModel: WishListViewModel
    private var cancellables = Set<AnyCancellable>()
    ///
    var isShowBackButton = false
    weak var coordinator: WishlistTransitionDelegate?
    // MARK: - Init
    init(viewModel: WishListViewModel) {
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
        bindViewModel()
        configureCompositionalLayout()
        setUpCollectionView()
    }
}
// MARK: - Configure
//
extension WishListViewController {
    /// Set up Navigation Bar
    private func setUpNavigationBar() {
        navigationItem.backButtonTitle = ""
        navigationBarBehavior.configure(
            title: "",
            titleColor: .primaryBlue,
            onPlus: { },
            showRighBtn: false,
            showBackButton: isShowBackButton) { [weak self] in
                self?.coordinator?.backToProfileVC()
            }
    }
    
    private func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    /// Configure Layout
    private func configureCompositionalLayout() {
        let layoutFactory = SectionsLayout(providers: viewModel.getLayoutProviders())
        self.collectionView.setCollectionViewLayout(layoutFactory.createLayout(), animated: true)
        viewModel.sections.forEach { $0.registerCells(in: collectionView) }
    }
}
// MARK: - UICollectionViewDelegate
//
extension WishListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        contextMenuConfigurationForItemAt indexPath: IndexPath,
                        point: CGPoint) -> UIContextMenuConfiguration? {
        if let providers = viewModel.section(at: indexPath.section) as? ContextMenuProvider {
            return providers.contextMenuConfiguration(for: collectionView, at: indexPath, point: point)
        }
        return nil
    }
}
// MARK: - UICollectionViewDataSource
//
extension WishListViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return viewModel.section(at: indexPath.section)
            .cellForItems(collectionView, cellForItemAt: indexPath)
    }
}
// MARK: - Header And Footer
//
extension WishListViewController {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let provider = viewModel.section(at: indexPath.section) as? HeaderAndFooterProvider {
            return provider.cellForItems(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath)
        }
        return UICollectionReusableView()
    }
}
// MARK: - Binding
//
extension WishListViewController {
    private func bindViewModel() {
        viewModel
            .$sections
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                /// Must Register cells whenever sections change
                viewModel.sections.forEach { $0.registerCells(in: self.collectionView) }
                self.collectionView.reloadData()
            }
            .store(in: &cancellables)
    }
}
