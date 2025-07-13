import Combine
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
    private var sections: [CollectionViewDataSource] = []
    private var layoutProviders: [LayoutSectionProvider] = []
    private var navigationBarBehavior: HerfetyNavigationController?
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var paymentButton: PrimaryButton!
    // MARK: - Properties
    weak var coordinator: InfoTransitionDelegate?
    weak var alertPresenter: AlertPresenter?
    ///
    var subscriptions = Set<AnyCancellable>()
    // MARK: - Lifcycle
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
        collectionView.delegate = self
        sections.forEach { $0.registerCells(in: collectionView) }
    }
    /// Configure Section
    private func configureSections() {
        CustomeTabBarViewModel.shared.$infos
            .receive(on: RunLoop.main)
            .sink { [weak self] infoItems in
                guard let self = self else { return }

                let infoSection = InfoCollectionViewSection(
                    infoItems: infoItems
                )
                self.sections = [infoSection]
                self.layoutProviders = [InfoSectionLayoutProvider()]

                infoSection.registerCells(in: self.collectionView)  // ✅ FIX HERE
                self.updateCollectionViewLayout()  // 👈 Fixes the layout error
                self.collectionView.reloadData()

                infoSection.deleteItemSubject
                    .sink { index in
                        var items = CustomeTabBarViewModel.shared.infos
                        guard index < items.count else { return }
                        items.remove(at: index)
                        CustomeTabBarViewModel.shared.infos = items
                    }
                    .store(in: &subscriptions)
            }
            .store(in: &subscriptions)
    }

    /// Configure Layout
    private func configureCompositianalLayout() {
        let layoutFactory = SectionsLayout(providers: layoutProviders)
        self.collectionView.setCollectionViewLayout(
            layoutFactory.createLayout(),
            animated: true
        )
    }
    private func updateCollectionViewLayout() {
        let layoutFactory = SectionsLayout(providers: layoutProviders)
        collectionView.setCollectionViewLayout(
            layoutFactory.createLayout(),
            animated: false
        )
    }

    /// Configure UI
    private func configureUI() {
        paymentButton.title = "Proceed to payment"
    }
    /// Set up Navigation Bar
    private func setUpNavigationBar() {

        navigationItem.backButtonTitle = ""

        navigationBarBehavior = HerfetyNavigationController(
            navigationItem: navigationItem,
            navigationController: navigationController
        )

        navigationBarBehavior?.configure(
            title: "Info",
            titleColor: .primaryBlue,
            onPlus: { [weak self] in
                guard let self = self else { return }
                /// plus button is tapped
                self.viewModel.didTapPlusButton(
                    navigationController: navigationController
                )
            },
            showBackButton: true) { [weak self] in
                self?.coordinator?.backToCartVC()
            }
    }
    /// Notification Center
    private func configureNotificationCenter() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(reloadCollectionView),
            name: Notification.Name("infoItemsUpdated"),
            object: nil
        )
    }
    /// Reloud collectionView
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
}
// MARK: - UICollectionViewDelegate
//
extension InfoViewController: UICollectionViewDelegate {
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
// MARK: - Binding
//
extension InfoViewController {
    /// Navigate to Credit Card
    private func bindViewModel() {
        viewModel.navigationToPayment = { [weak self] in
            let creditCardVC = MyCheckoutViewController()
            self?.navigationController?.pushViewController(
                creditCardVC,
                animated: true)
        }

        /// Not navigatte
        viewModel.$infoState
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
