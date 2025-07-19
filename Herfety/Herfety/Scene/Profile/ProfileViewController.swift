//
//  ProfileViewController.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 09/02/2025.
//

import UIKit
import Combine

class ProfileViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    // MARK: - Properties
    private var nameViewModel: NameViewModel
    private var profileListViewModel: ProfileListViewModel
    private var sections: [CollectionViewDataSource] = []
    private var layoutSections: [LayoutSectionProvider] = []
    ///
    weak var coordinator: PorfileTransionDelegate?
    private var subscription =  Set<AnyCancellable>()
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
        navigationItem.backButtonTitle = ""
        configureSections()
        configureLayoutSections()
        setUpCollectionView()
        bindViewModel()
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
        let firstList = ProfileListCollectionViewSection(items: profileListViewModel.firstList, coordinator: coordinator)
        // 3) Second list
        let secondList = ProfileListCollectionViewSection(items: profileListViewModel.secondList, coordinator: coordinator)
        
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
extension ProfileViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectable = sections[indexPath.section] as? CollectionViewDelegate {
            selectable.collectionView(collectionView, didSelectItemAt: indexPath)
        }
    }
}
// MARK: - Binding
//
extension ProfileViewController {
    func bindViewModel() {
        nameViewModel.$nameItem
            .receive(on: DispatchQueue.main)
            .sink { [weak self] updatedName in
                guard let self else { return }
                // Update the header section
                if let nameSection = self.sections.first as? NameOfProfileCollectionViewSection {
                    nameSection.sectionName.image = updatedName.image
                    nameSection.sectionName.name = updatedName.name
                    nameSection.sectionName.email = updatedName.email
                }
                self.collectionView.reloadSections(IndexSet(integer: 0)) 
            }
            .store(in: &subscription)
    }
}
