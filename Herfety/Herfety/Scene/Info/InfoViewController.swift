//
//  ShippingViewController.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 13/02/2025.
//

import UIKit

class InfoViewController: UIViewController {

    // MARK: - Properties
    private var viewModel = InfoViewModel()
    private var sections: [CollectionViewProvider] = []
    private var layoutProviders: [SectionLayoutProvider] = []
    private var navigationBarBehavior: ShippingNavBar?
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var paymentButton: PrimaryButton!
    
    // MARK: - Lifcycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureProvider()
        configureCompositianalLayout()
        setUpCollectionView()
        configureUI()
        setUpNavigationBar()
        bindViewModel()
    }
}

// MARK: - Configuration
//
extension InfoViewController {
    
    private func setUpCollectionView() {
        collectionView.dataSource = self
        
        sections.forEach { $0.registerCells(in: collectionView) }
    }
    private func configureProvider() {
        let infoSection = InfoCollectionViewSection(shippingItems: viewModel.shippingItems)
        sections = [infoSection]
        
        layoutProviders.append(ShippingInfoSectionLayoutProvider())
    }
    // Configure Layout
    private func configureCompositianalLayout() {
        let layoutFactory = SectionsLayout(providers: layoutProviders)
        self.collectionView.setCollectionViewLayout(layoutFactory.createLayout(), animated: true)
    }
    
    // Configure UI
    private func configureUI() {
        paymentButton.title = "Proceed to payment"
    }
    
    // Set up Navigation Bar
    private func setUpNavigationBar() {
        
        navigationItem.backButtonTitle = ""
        
        navigationBarBehavior = ShippingNavBar(navigationItem: navigationItem, navigationController: navigationController)
        navigationBarBehavior?.configure(title: "Info", titleColor: .primaryBlue,onPlus: { [weak self] in
             // plus button is tapped
            let addressVC = AddAddressViewController(viewModel: AddAddressViewModel())
            self?.navigationController?.pushViewController(addressVC, animated: true)
        })
    }
}

// MARK: - UICollectionViewDataSource
//
extension InfoViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        sections[indexPath.section].cellForItems(collectionView, cellForItemAt: indexPath)
    }
}

// MARK: - Binding
//
extension InfoViewController {
    private func bindViewModel() {
//        viewModel.navigationToPayment = { [weak self] in
//            let paymentVc = PaymentViewController()
//            navigationController?.pushViewController(paymentVc, animated: true)
//        }
        print("Binding to navigate payment VC")
    }
}
// MARK: - Actions
//
extension InfoViewController {
    
    @IBAction func paymentPressed(_ sender: Any) {
//        print("Payment Pressed")
        viewModel.didTapPaymentButton()
    }
}
