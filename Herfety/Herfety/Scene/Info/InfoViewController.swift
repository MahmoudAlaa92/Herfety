//
//  InfoViewController.swift
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
    private var navigationBarBehavior: InfoNavBar?
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var paymentButton: PrimaryButton!
    
    // MARK: - Lifcycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSections()
        configureCompositianalLayout()
        setUpCollectionView()
        configureUI()
        setUpNavigationBar()
        bindViewModel()
        configureNotificationCenter()
    }
}

// MARK: - Configuration
//
extension InfoViewController {
    
    private func setUpCollectionView() {
        collectionView.dataSource = self

        sections.forEach { $0.registerCells(in: collectionView) }
    }
    private func configureSections() {
        let infoSection = InfoCollectionViewSection(infoItems: viewModel.infoItems)
        sections = [infoSection]
        
        layoutProviders = [InfoSectionLayoutProvider()]
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
        
        navigationBarBehavior = InfoNavBar(navigationItem: navigationItem, navigationController: navigationController)
        
        navigationBarBehavior?.configure(title: "Info", titleColor: .primaryBlue, onPlus: { [weak self] in
            guard let self = self else { return }
            /// plus button is tapped
            self.viewModel.didTapPlusButton(navigationController: navigationController)
        })
    }
    
    // Notification Center
    private func configureNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCollectionView), name: Notification.Name("infoItemsUpdated"), object: nil)
    }
    
    // Reloud collectionView
   @objc private func reloadCollectionView() {
       configureSections()
       DispatchQueue.main.async { [weak self] in
           self?.collectionView.reloadData()
       }
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
    // Navigate to Credit Card
    private func bindViewModel() {
        viewModel.navigationToPayment = { [weak self] in
            let creditCardVC = CreditCardViewController(viewModel: CreditCardViewModel())
            self?.navigationController?.pushViewController(creditCardVC, animated: true)
        }
    }
}
// MARK: - Actions
//
extension InfoViewController {
    
    @IBAction func paymentPressed(_ sender: Any) {
        viewModel.didTapPaymentButton()
    }
}
