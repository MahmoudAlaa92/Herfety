//
//  SettingViewController.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 07/03/2025.
//

import UIKit
import Combine

class SettingViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    // MARK: - Properties
    private(set) var settingViewModel: SettingViewModel
    private(set) var sections: [CollectionViewDataSource] = []
    private(set) var layoutSections: [LayoutSectionProvider] = []
    private var navigationBarBehavior: HerfetyNavigationController?
    ///
    weak var ProfileCoordinator: PorfileTransionDelegate?
    weak var coordinator: SettingTransitionDelegate?
    ///
    var subcriptions = Set<AnyCancellable>()
    // MARK: - Init
    init(settingViewModel: SettingViewModel) {
        self.settingViewModel = settingViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSections()
        configureLayoutSections()
        setUpCollectionView()
        setUpNavigationBar()
        bindViewModel()
    }
}
// MARK: - Configuration
//
extension SettingViewController {
 
    private func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    private func configureSections() {
        /// 1) First list
        let firstList = SettingCollectionViewSection(items: settingViewModel.firstList)
        /// 2) Second list
        let secondList = ProfileListCollectionViewSection(items: settingViewModel.secondList, coordinator: ProfileCoordinator)
        /// 3) Logout button
        let logoutButton = LogoutButtonCollectionViewSection()
        logoutButton.onLogoutPressed.sink { [weak self] in
            self?.settingViewModel.onLogout?()
        }.store(in: &subcriptions)
        sections = [firstList, secondList, logoutButton]
        sections.forEach({ $0.registerCells(in: collectionView) })
    }
    private func configureLayoutSections() {
        /// 1) First list
        let firstList = SettingCollectionLayoutSection()
        /// 2) Second list
        let secondList = ProfileListLayoutSection()
        /// 3) Lagout button
        let logoutButton = LogoutButtonCollectionLayoutSection()
        layoutSections = [firstList, secondList, logoutButton]
        
        /// Set Layout in collectionView
        ///
        let layoutFactory = SectionsLayout(providers: layoutSections).createLayout()
        layoutFactory.register(SectionDecorationView.self, forDecorationViewOfKind: SectionDecorationView.identifier)
        
        collectionView.setCollectionViewLayout(layoutFactory, animated: true)
    }
    /// Set up Navigation Bar
    private func setUpNavigationBar() {
        
        navigationItem.backButtonTitle = ""
        
        navigationBarBehavior = HerfetyNavigationController(
            navigationItem: navigationItem,
            navigationController: navigationController
        )
        
        navigationBarBehavior?.configure(
            title: "",
            titleColor: .primaryBlue,
            onPlus: { },
            showRighBtn: false,
            showBackButton: true) { [weak self] in
                self?.coordinator?.backToProfileVC()
            }
    }
}
// MARK: - DataSource
//
extension SettingViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].numberOfItems
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        sections[indexPath.section].cellForItems(collectionView, cellForItemAt: indexPath)
    }
    /// Header & Footer
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let provider = sections[indexPath.section] as? HeaderAndFooterProvider else {
            /// provider does not support headers/footers.
            return UICollectionReusableView()
        }
        return provider.cellForItems(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath)
    }
}
// MARK: - Delegate
//
extension SettingViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {

        let section = sections[indexPath.section]
        let animation = section.animationForSection()
        let duration = section.animationDuration()
        
        cell.animate(animations: [animation], duration: duration)
    }
}
// MARK: - Binding
//
extension SettingViewController {
    func bindViewModel() {
        settingViewModel.onLogout = { [weak self] in
            self?.coordinator?.goToAuthVC()
        }
    }
}

