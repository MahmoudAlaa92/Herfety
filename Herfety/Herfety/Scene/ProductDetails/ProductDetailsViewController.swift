//
//  ProductDetailsViewController.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 27/02/2025.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    
    // MARK: - Properties
    //
    @IBOutlet weak var collectionView: UICollectionView!
    ///
    private var viewModel: ProductDetailsViewModel
    private var sections: [CollectionViewProvider] = []
    private var layoutSections: [LayoutSectionProvider] = []
    
    // MARK: - Init
    init(viewModel:  ProductDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        configureSections()
        configureLayoutSections()
    }
}
// MARK: - Configuration
//
extension ProductDetailsViewController {
    // CollectoinView
    private func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    // Sections
    private func configureSections() {
        let imagesProducts = ProductDetailsCollectionViewSection(productItems: viewModel.productItems)
        let reviews = ReviewCollectionViewSection(reviewItems: viewModel.reviewsItems, rating: viewModel.productItems)
        let recommendItems = CardItemCollectionViewSection(productItems: viewModel.recommendItems)
        recommendItems.headerConfigurator = { header in
            header.configure(title: "Recommended for you", description: "", shouldShowButton: false)
        }
        sections = [imagesProducts, reviews, recommendItems]
        
        sections.forEach( { $0.registerCells(in: collectionView) } )
    }
    // Layout
    private func configureLayoutSections() {
        let productImages = ProductDetailsCollectionViewProvider()
        let review = ReviewCollectionViewSectionLayout()
        let recommendItems = CardProductSectionLayoutProvider()
        
        layoutSections = [productImages, review, recommendItems]
        
        let layoutFactory = SectionsLayout(providers: layoutSections)
        collectionView.setCollectionViewLayout(layoutFactory.createLayout(), animated: true)
    }
}
// MARK: - UICollectionViewDataSource
//
extension ProductDetailsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        sections[indexPath.section].cellForItems(collectionView, cellForItemAt: indexPath)
    }
    
    // Header And Footer
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if let provider = sections[indexPath.section] as? HeaderAndFooterProvider {
            return provider.cellForItems(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath)
        }
        
        return UICollectionReusableView()
    }
}
// MARK: - UICollectionViewDelegate
//
extension ProductDetailsViewController:  UICollectionViewDelegate {}

