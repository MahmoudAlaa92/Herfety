//
//  SettingViewController.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 07/03/2025.
//

import UIKit

class SettingViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    // MARK: - Properties
    private(set) var settingViewModel: SettingViewModel
    private(set) var sections: [CollectionViewDataSource] = []
    private(set) var layoutSections: [LayoutSectionProvider] = []
    ///
    weak var coordinator: PorfileTransionDelegate?
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
        let secondList = ProfileListCollectionViewSection(items: settingViewModel.secondList, coordinator: coordinator)
        /// 3) Logout button
        let logoutButton = LogoutButtonCollectionViewSection()
        
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
extension SettingViewController: UICollectionViewDelegate {}
