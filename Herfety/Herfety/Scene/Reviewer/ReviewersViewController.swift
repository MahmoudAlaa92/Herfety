//
//  ReviewersViewController.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 03/03/2025.
//

import Combine
import UIKit

class ReviewersViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var collectionView: UICollectionView!
    ///
    var viewModel: ReviewersViewModel
    private var sections: [CollectionViewDataSource] = []
    private var sectionsLayout: [LayoutSectionProvider] = []
    private var navBarBehavior: HerfetyNavigationController?
    private var subscriptions = Set<AnyCancellable>()
    weak var coordinator: ReviewersTransitionDelegate?
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
        configureLayoutSections()
    }
    override func viewWillAppear(_ animated: Bool) {
        Task {
            await viewModel.fetchReviews()
            reloadData()
        }
    }
}
// MARK: - Configuration
//
extension ReviewersViewController {

    private func reloadData() {
        let section = ReviewerCollectionViewSection(
            reviewers: viewModel.reviewersItems
        )
        section.onDelete = { [weak self] index in
            guard let self = self else { return }

            Task {
                let success = await self.viewModel.deletReview(at: index)
                if success { self.reloadData() }
            }
            
        }
        
        section.onUpdate = { [weak self] index, newText in
            guard let self = self else { return }

            Task {
                let success = await self.viewModel.updateReview(at: index, with: newText)
                if success {
                    self.reloadData()
                }
            }
            
        }
        sections = [section]
        collectionView.reloadData()
    }

    private func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    private func configureSections() {
        let reviewrs = ReviewerCollectionViewSection(
            reviewers: viewModel.reviewersItems
        )
        sections = [reviewrs]
        sections.forEach({ $0.registerCells(in: collectionView) })
    }
    private func configureLayoutSections() {
        let reviewers = ReviewerCollectionViewLayoutSection()
        sectionsLayout = [reviewers]

        let layoutFactory = SectionsLayout(providers: sectionsLayout)

        collectionView.setCollectionViewLayout(
            layoutFactory.createLayout(),
            animated: true
        )
    }

    private func setUpNavigationBar() {
        navBarBehavior = HerfetyNavigationController(
            navigationItem: navigationItem,
            navigationController: navigationController
        )
        navBarBehavior?.configure(
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
}
// MARK: - UICollectionViewDataSource
//
extension ReviewersViewController: UICollectionViewDataSource {
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
        if kind == HeaderView.headerIdentifier,
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: HeaderView.headerIdentifier,
                withReuseIdentifier: HeaderView.headerIdentifier,
                for: indexPath
            ) as? HeaderView
        {
            header.configure(
                title: "Reviews Client",
                description: "",
                titleFont: .title3,
                shouldShowButton: false
            )
            return header
        }
        return UICollectionReusableView()
    }
}
// MARK: - UICollectionViewDelegate
//
extension ReviewersViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        contextMenuConfigurationForItemAt indexPath: IndexPath,
        point: CGPoint
    ) -> UIContextMenuConfiguration? {
        if let providers = sections[indexPath.section] as? ContextMenuProvider {
            return providers.contextMenuConfiguration(
                for: collectionView,
                at: indexPath,
                point: point
            )
        }
        return nil
    }
}
