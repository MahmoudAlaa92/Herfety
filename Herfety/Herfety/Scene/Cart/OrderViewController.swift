//
//  CartViewController.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 09/02/2025.
//

import UIKit
import Combine

class OrderViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak private(set) var paymentView: PaymentView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var proccedToPayment: PrimaryButton!
    // MARK: - Properties
    private let orderViewModel = OrderViewModel()
    private lazy var paymentViewModel: PaymentView.Model = {
        return orderViewModel.paymentInfo
    }()
    private var viewModel = OrderViewModel()
    private var sections: [CollectionViewDataSource] = []
    private var layoutProviders: [LayoutSectionProvider] = []
    ///
    var subscriptions = Set<AnyCancellable>()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureProvider()
        setUpCollectionView()
        cofigureCompositianalLayout()
        configureViews()
        configureUI()
        setUpNavigationBar()
        bindViewModel()
    }
}
// MARK: - UICollectionViewDataSource
//
extension OrderViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        sections[indexPath.section].cellForItems(collectionView, cellForItemAt: indexPath)
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
// MARK: - Delegate
//
extension OrderViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        contextMenuConfigurationForItemAt indexPath: IndexPath,
                        point: CGPoint) -> UIContextMenuConfiguration? {
        if let providers = sections[indexPath.section] as? ContextMenuProvider {
            return providers.contextMenuConfiguration(for: collectionView, at: indexPath, point: point)
        }
        return nil
    }
}
// MARK: - Configurations
//
private extension OrderViewController {
    
    /// Binds the payment view with the computed PaymentView.Model.
    private func configureViews() {
        paymentView.configure(with: paymentViewModel)
    }
    
    private func setUpCollectionView() {
        collectionView.dataSource =  self
        collectionView.delegate = self
        sections.forEach { $0.registerCells(in: collectionView) }
    }
    
    private func configureProvider() {
        CustomeTabBarViewModel.shared.$cartItems.sink { [weak self] value in
            let orderProvider = OrderCollectionViewSection(orderItems: value)
            guard let self = self else { return }
            self.sections = [orderProvider]
            self.collectionView.reloadData()
            
            /// Combine subscription to count updates
            orderProvider.countUpdateSubject
                .sink { [weak self] index, newCount in
                    guard let self = self else { return }
                    self.viewModel.updateOrderCount(at: index, to: newCount)
                }
                .store(in: &self.subscriptions)
        }.store(in: &CustomeTabBarViewModel.shared.subscriptions)

        layoutProviders.append(OrderSectionLayoutProvider())
    }
    
    // Configure Layout
    private func cofigureCompositianalLayout() {
        let layoutFactory = SectionsLayout(providers: layoutProviders)
        self.collectionView.setCollectionViewLayout(layoutFactory.createLayout(), animated: true)
    }
    
    // Configure UI
    private func configureUI() {
        proccedToPayment.title = "Procced to Payment"
    }
    
    // Navigation Bar
    private func setUpNavigationBar() {
        navigationItem.backButtonTitle = ""
    }
}
// MARK: - Binding
//
extension OrderViewController {
    
    private func bindViewModel() {
        // Navigate to Shipping VC
        bindOrderItems()
        viewModel.navigationToShipping = { [weak self] in
            let shippingVC = InfoViewController()
            self?.navigationController?.pushViewController(shippingVC, animated: true)
        }
    }
    private func bindOrderItems() {
        // Bind payment info
        viewModel.$paymentInfo
            .receive(on: RunLoop.main)
            .sink { [weak self] paymentModel in
                self?.paymentView.configure(with: paymentModel)
            }
            .store(in: &subscriptions)
    }
}
// MARK: - Actions
//
extension OrderViewController {
 
    @IBAction func paymentPressed(_ sender: Any) {
       // payment Pressed in order
        viewModel.didTapPayment()
    }
}
// MARK: - Private Handlers ???
//
extension OrderViewController {}
