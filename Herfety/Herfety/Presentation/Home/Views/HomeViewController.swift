//
//  HomeViewController.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 04/02/2025.
//
import UIKit
import Combine
import ViewAnimator

class HomeViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    private var viewModel: HomeViewModel
    private var navigationBarBehavior: HomeNavBar?
    weak var coordinator: HomeTranisitionProtocol?
    weak var alertPresenter: AlertPresenter?
    private var cancellabels = Set<AnyCancellable>()
    
    // MARK: - Init
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        configureSections()
        bindViewModel()
        Task {
            await viewModel.fetchData()
            await configureNavBar()
        }
    }
}
// MARK: - Configuration
//
extension HomeViewController {
    /// NavBar
    func configureNavBar() async {
        navigationItem.backButtonTitle = ""
        navigationBarBehavior = HomeNavBar(navigationItem: navigationItem)
        
        let userName = await DataStore.shared.getUserInfo()?.UserName ?? ""
        let userImage = await DataStore.shared.getUserProfileImage()
        navigationBarBehavior?.configure(
            onNotification: { [weak self] in
                self?.coordinator?.gotToSafari(url: "https://9ec0-34-74-104-29.ngrok-free.app/")
            },
            onSearch: { [weak self] in
                self?.coordinator?.goToSearchVC(discount: 80)
            },
            userName: userName,
            userImage: userImage
        )
    }
    
    private func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    /// Configure Sections
    private func configureSections() {
        let layoutFactory = SectionsLayout(providers: viewModel.layoutSections)
        self.collectionView.setCollectionViewLayout(layoutFactory.createLayout(), animated: true)
        viewModel.sections.forEach { $0.registerCells(in: collectionView) }
    }
}
// MARK: - UICollectionViewDelegate
//
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectable = viewModel.sections[indexPath.section] as? CollectionViewDelegate {
            selectable.collectionView(collectionView, didSelectItemAt: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {

        let section = viewModel.sections[indexPath.section]
        let animation = section.animationForSection()
        let duration = section.animationDuration()
        
        cell.animate(animations: [animation], duration: duration)
    }
}
// MARK: - UICollectionViewDataSource
//
extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.sections[section].numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return viewModel.sections[indexPath.section].cellForItems(collectionView, cellForItemAt: indexPath)
    }
    
    // MARK: - Header And Footer
    //
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if let provider = viewModel.sections[indexPath.section] as? HeaderAndFooterProvider {
            return provider.cellForItems(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath)
        }
        /// provider does not support headers/footers.
        return UICollectionReusableView()
    }
}
// MARK: - Binding
//
extension HomeViewController {
    private func bindViewModel() {
        bindSections()
        bindAlert()
    }
    /// Sections
    private func bindSections() {
        viewModel
            .$categoryItems
            .receive(on: DispatchQueue.main)
            .sink { [weak self] items in
                guard let self = self else { return }
                /// Update the section's data first
                if let categorySection = self.viewModel.sections[HomeSection.categories.rawValue] as? CategoryCollectionViewSection {
                    categorySection.categoryItems = items
                }
                
                let sectionIndex = HomeSection.categories.rawValue
                self.collectionView.performBatchUpdates({
                    self.collectionView.reloadSections(IndexSet(integer: sectionIndex))
                }, completion: { _ in
                    self.collectionView.animateVisibleCellsin(section: sectionIndex,
                                                              animation: .from(direction: .right, offset: 40))
                })
            }
            .store(in: &cancellabels)
        ///
        viewModel
            .$productItems
            .receive(on: DispatchQueue.main)
            .sink { [weak self] items in
                guard let self = self else { return }
                /// Update the section's data first
                if let productSection = self.viewModel.sections[HomeSection.products.rawValue] as? CardItemCollectionViewSection {
                    productSection.productItems = items
                }
                
                let sectionIndex = HomeSection.products.rawValue
                self.collectionView.performBatchUpdates({
                    self.collectionView.reloadSections(IndexSet(integer: sectionIndex))
                }, completion: { _ in
                    self.collectionView.animateVisibleCellsin(section: sectionIndex,
                                                              animation: .from(direction: .right, offset: 40))
                })
            }
            .store(in: &cancellabels)
    }
    /// Alert
    private func bindAlert() {
        viewModel
            .$showAlert
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .dropFirst()
            .sink { [weak self] alert in
                self?.alertPresenter?.showAlert(alert)
            }
            .store(in: &cancellabels)
    }
}
