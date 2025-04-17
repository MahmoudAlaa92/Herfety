//
//  ProductsViewController.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 22/02/2025.
//

import UIKit

class ProductsViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    private(set) var viewModel: ProductsViewModel
    private var sections = [CollectionViewProvider]()
    private var layoutSections = [LayoutSectionProvider]()
    
    // MARK: Init
    init(viewModel: ProductsViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSections()
        configureLayout()
        setUpCollectionView()
    }

}
// MARK: - Configuraion
//
extension ProductsViewController {

    private func configureSections() {
        let products = ProductsCollectionViewSection(Products: viewModel.productItems)
        sections = [products]
        
        layoutSections.append(ProductsCollectionViewSectionLayout())
    }

    private func configureLayout() {
        let factory = SectionsLayout(providers: layoutSections)
        collectionView.setCollectionViewLayout(factory.createLayout(), animated: true)
    }
    
    private func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        sections.forEach({ $0.registerCells(in: collectionView)})
    }
}
// MARK: - UICollectionViewDataSource
//
extension ProductsViewController:UICollectionViewDataSource {
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
// MARK: - UICollectionViewDelegate
//
extension ProductsViewController: UICollectionViewDelegate {}
