//
//  ProfileViewController.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 09/02/2025.
//

import UIKit

class ProfileViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    // MARK: - Properties
    private var nameViewModel: NameViewModel
    private var profileListViewModel: ProfileListViewModel
    private var sections: [CollectionViewDataSource] = []
    private var layoutSections: [LayoutSectionProvider] = []
    // MARK: - Init
    init(nameViewModel: NameViewModel, profileListViewModel: ProfileListViewModel){
        self.nameViewModel = nameViewModel
        self.profileListViewModel = profileListViewModel
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
extension ProfileViewController {
    private func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    private func configureSections() {
        // 1) Header
        let name = NameOfProfileCollectionViewSection(sectionName: nameViewModel.nameItem)
        // 2) First list
        let firstList = ProfileListCollectionViewSection(items: profileListViewModel.firstList)
        // 3) Second list
        let secondList = ProfileListCollectionViewSection(items: profileListViewModel.secondList)
        
        sections = [name, firstList, secondList]
        sections.forEach( { $0.registerCells(in: collectionView) })
    }
    private func configureLayoutSections() {
        // 1) Header
        let name = NameCollectionViewLayoutSection()
        // 2) First list
        let firstList = ProfileListLayoutSection()
        // 3) Second list
        let secondList = ProfileListLayoutSection()
        
        layoutSections = [name, firstList, secondList]
        
        let layoutFactory = SectionsLayout(providers: layoutSections).createLayout()
        
        // Register the decoration view
        layoutFactory.register(SectionDecorationView.self, forDecorationViewOfKind: SectionDecorationView.identifier)
        
        // Set Layout in collectionView
        collectionView.setCollectionViewLayout(layoutFactory, animated: true)
    }
}
// MARK: - DataSource
//
extension ProfileViewController: UICollectionViewDataSource {
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
// MARK: - Delegate
//
extension ProfileViewController: UICollectionViewDelegate { }
