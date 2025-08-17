//
//  CartViewController.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 09/02/2025.
//

import Combine
import UIKit

class CartViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak private(set) var paymentView: PaymentView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var proccedToPayment: PrimaryButton!
    
    // MARK: - Properties
    private(set) var viewModel: CartViewModel
    private lazy var paymentViewModel: PaymentView.Model = {
        return viewModel.paymentInfo
    }()
    private lazy var navigationBarBehavior = HerfetyNavigationController(
        navigationItem: navigationItem,
        navigationController: navigationController)
    ///
    private var cancellables = Set<AnyCancellable>()
    ///
    weak var coordinator: CartTransitionDelegate?
    weak var alertPresenter: AlertPresenter?
    
    // MARK: - Init
    init(viewModel: CartViewModel) {
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
        configureCompositionalLayout()
        setUpCollectionView()
        bindViewModel()
        configureUI()
    }
}
// MARK: - UICollectionViewDataSource
//
extension CartViewController: UICollectionViewDataSource {
    
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
    // MARK: - Header And Footer
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
        /// provider does not support headers/footers.
        return UICollectionReusableView()
    }
}
// MARK: - Delegate
//
extension CartViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        contextMenuConfigurationForItemAt indexPath: IndexPath,
        point: CGPoint
    ) -> UIContextMenuConfiguration? {
        if let providers = viewModel.sections[indexPath.section]
            as? ContextMenuProvider
        {
            return providers.contextMenuConfiguration(
                for: collectionView,
                at: indexPath,
                point: point
            )
        }
        return nil
    }
}
// MARK: - Configurations
//
extension CartViewController {
    /// Set up Navigation Bar
    private func setUpNavigationBar() {
        navigationItem.backButtonTitle = ""
        navigationBarBehavior.configure(
            title: "",
            titleColor: .primaryBlue,
            onPlus: {},
            showRighBtn: false,
            showBackButton: viewModel.isShowBackButton
        ) { [weak self] in
            self?.coordinator?.backToProfileVC()
        }
    }
    /// Binds the payment view with the computed PaymentView.Model.
    private func configureViews() {
        paymentView.configure(with: paymentViewModel)
    }
    
    private func setUpCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    /// Configure Layout
    private func configureCompositionalLayout() {
        let layoutFactory = SectionsLayout(
            providers: viewModel.layoutProviders)
        self.collectionView.setCollectionViewLayout(
            layoutFactory.createLayout(),
            animated: true)
        ///
        viewModel.sections.forEach { $0.registerCells(in: collectionView) }
    }
    /// Configure UI
    private func configureUI() {
        proccedToPayment.title = "Procced to Payment"
    }
}
// MARK: - Actions
//
extension CartViewController {
    @IBAction func paymentPressed(_ sender: Any) {
        /// payment Pressed in order
        viewModel.didTapPayment()
    }
}

// MARK: - Binding
//
extension CartViewController {
    
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
        /// Navigate to Shipping VC
        viewModel
            .navigationToShipping = { [weak self] in
                self?.coordinator?.goToInfoVC()
            }
        ///
        viewModel
            .$paymentInfo
            .receive(on: DispatchQueue.main)
            .sink { [weak self] paymentModel in
                self?.paymentView.configure(with: paymentModel)
            }
            .store(in: &cancellables)
        /// Procced to Payment
        viewModel
            .$orderAlert
            .compactMap({ $0 })
            .sink { [weak self] alert in
                self?.alertPresenter?.showAlert(alert)
            }.store(in: &cancellables)
    }
}
