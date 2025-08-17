//
//  InfoViewController.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 13/02/2025.
//

import UIKit
import Combine

class InfoViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var paymentButton: PrimaryButton!
    // MARK: - Properties
    private var viewModel: InfoViewModel
    private lazy var navigationBarBehavior = HerfetyNavigationController(
        navigationItem: navigationItem,
        navigationController: navigationController
    )
    weak var coordinator: InfoTransitionDelegate?
    weak var alertPresenter: AlertPresenter?
    ///
    var subscriptions = Set<AnyCancellable>()
    // MARK: - Init
    init(viewModel: InfoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Lifcycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSections()
        setUpCollectionView()
        configureUI()
        setUpNavigationBar()
        bindViewModel()
    }
}
// MARK: - Configuration
//
extension InfoViewController {
    /// Set up Navigation Bar
    private func setUpNavigationBar() {
        navigationItem.backButtonTitle = ""
        navigationBarBehavior.configure(
            title: "Info",
            titleColor: .primaryBlue,
            onPlus: { [weak self] in
                guard let self = self else { return }
                /// plus button is tapped
                self.coordinator?.goToAddAddressVC()
            },
            showBackButton: true) { [weak self] in
                self?.coordinator?.backToCartVC()
            }
    }
    private func setUpCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        viewModel.sections.forEach { $0.registerCells(in: collectionView) }
    }
    /// Configure Section
    private func configureSections() {
        let layoutFactory = SectionsLayout(providers: viewModel.layoutProviders)
        collectionView.setCollectionViewLayout(
            layoutFactory.createLayout(),
            animated: false
        )
    }
    /// Configure UI
    private func configureUI() {
        paymentButton.title = "Proceed to payment"
    }
}
// MARK: - UICollectionViewDataSource
//
extension InfoViewController: UICollectionViewDataSource {
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
extension InfoViewController: UICollectionViewDelegate {
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
extension InfoViewController {
    private func bindViewModel() {
        viewModel
            .$sections
            .sink { [weak self] _  in
                self?.collectionView.reloadData()
            }
            .store(in: &subscriptions)
        viewModel
            .navigationToPayment = { [weak self] in
                self?.coordinator?.goToCheckoutVC()
            }
        viewModel
            .$infoState
            .compactMap({ $0 })
            .sink { [weak self] alert in
                self?.alertPresenter?.showAlert(alert)
            }.store(in: &subscriptions)
    }
}
// MARK: - Actions
//
extension InfoViewController {
    
    @IBAction func paymentPressed(_ sender: Any) {
        viewModel.didTapPaymentButton()
    }
}
