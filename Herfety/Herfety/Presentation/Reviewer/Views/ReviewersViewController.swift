//
//  ReviewersViewController.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 03/03/2025.
//

import UIKit
import Combine
import ViewAnimator

class ReviewersViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    var viewModel: ReviewersViewModel
    private lazy var navBarBehavior = HerfetyNavigationController(
        navigationItem: navigationItem,
        navigationController: navigationController
    )
    weak var coordinator: ReviewersTransitionDelegate?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    init(viewModel: ReviewersViewModel) {
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
        setUpCollectionView()
        configureSections()
        bindViewModel()
    }
    override func viewWillAppear(_ animated: Bool) {
        Task {
            await viewModel.fetchReviews()
            collectionView.reloadData()
        }
    }
}
// MARK: - Configuration
//
extension ReviewersViewController {
    
    private func setUpNavigationBar() {
        navBarBehavior.configure(
            title: "",
            titleColor: Colors.primaryBlue,
            onPlus: { [weak self] in
                guard let self = self else { return }
                let viewModel = AddReviewViewModel(reviersItems: self.viewModel.reviewersItems, productId: self.viewModel.productId)
                self.coordinator?.goToAddReviewersVC(viewModel: viewModel)
            },
            showRighBtn: true,
            showBackButton: true,
            onBack: { [weak self] in
                self?.coordinator?.backToProductDetialsVC()
            }
        )
    }
    private func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    private func configureSections() {
        viewModel.sections.forEach({ $0.registerCells(in: collectionView) })
        
        let layoutFactory = SectionsLayout(providers: viewModel.sectionsLayout)
        collectionView.setCollectionViewLayout(
            layoutFactory.createLayout(),
            animated: true
        )
    }
}
// MARK: - UICollectionViewDataSource
//
extension ReviewersViewController: UICollectionViewDataSource {
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
    /// Header And Footer
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        if let provider = viewModel.sections[indexPath.section] as? HeaderAndFooterProvider {
            return provider.cellForItems(collectionView,
                                         viewForSupplementaryElementOfKind: kind,
                                         at: indexPath)
        }
        return UICollectionReusableView()
    }
}
// MARK: - UICollectionViewDelegate
//
extension ReviewersViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        cell.animate(animations: [AnimationType.from(direction: .bottom, offset: 30)], duration: 0.8)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        contextMenuConfigurationForItemAt indexPath: IndexPath,
        point: CGPoint
    ) -> UIContextMenuConfiguration? {
        if let providers = viewModel.sections[indexPath.section] as? ContextMenuProvider {
            return providers.contextMenuConfiguration(
                for: collectionView,
                at: indexPath,
                point: point
            )
        }
        return nil
    }
}
// MARK: - Binding
//
extension ReviewersViewController {
    func bindViewModel() {
        /// Bind reviewersItems changes
        viewModel.$reviewersItems
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                Task { @MainActor in
                    await self?.viewModel.refreshSections()
                }
            }
            .store(in: &cancellables)
        
        /// Bind sections changes
        viewModel.$sections
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.collectionView.reloadData()
            }
            .store(in: &cancellables)
    }
}
