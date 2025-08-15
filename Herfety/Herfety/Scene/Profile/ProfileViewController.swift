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
    private var viewModel: ProfileViewModel
    private var cancellabels =  Set<AnyCancellable>()
    // MARK: - Init
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
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
        viewModel.sections.forEach( { $0.registerCells(in: collectionView) })
    }
    private func configureSections() {
        let layoutFactory = SectionsLayout(providers: viewModel.layoutSections).createLayout()
        
        /// Register the decoration view
        layoutFactory.register(SectionDecorationView.self, forDecorationViewOfKind: SectionDecorationView.identifier)
        
        /// Set Layout in collectionView
        collectionView.setCollectionViewLayout(layoutFactory, animated: true)
    }
}
// MARK: - DataSource
//
extension ProfileViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.sections.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.sections[section].numberOfItems
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        viewModel.sections[indexPath.section].cellForItems(collectionView, cellForItemAt: indexPath)
    }
}
// MARK: - Delegate
//
extension ProfileViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectable = viewModel.sections[indexPath.section] as? CollectionViewDelegate {
            selectable.collectionView(collectionView, didSelectItemAt: indexPath)
        }
    }
}
// MARK: - Binding
//
extension ProfileViewController {
    private func bindViewModel() {
        viewModel
            .$sections
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                viewModel.sections.forEach( { $0.registerCells(in: self.collectionView) })
                self.collectionView.reloadData()
            }
            .store(in: &cancellabels)
    }
}
