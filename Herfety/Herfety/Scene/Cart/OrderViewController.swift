//
//  CartViewController.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 09/02/2025.
//

import UIKit

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
    private var sections: [CollectionViewProvider] = []
    private var layoutProviders: [LayoutSectionProvider] = []
    
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

// MARK: - Configurations
//
private extension OrderViewController {
    
    /// Binds the payment view with the computed PaymentView.Model.
    private func configureViews() {
        paymentView.configure(with: paymentViewModel)
    }
    
    private func setUpCollectionView() {
        collectionView.dataSource =  self
        
        sections.forEach { $0.registerCells(in: collectionView) }
    }
    
    private func configureProvider() {
        let orderProvider = OrderCollectionViewSection(orderItems: viewModel.orderItems)
        sections = [orderProvider]
        
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
        viewModel.navigationToShipping = { [weak self] in
            let shippingVC = InfoViewController()
            self?.navigationController?.pushViewController(shippingVC, animated: true)
        }
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
