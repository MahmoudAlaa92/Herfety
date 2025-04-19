//
//  ReviewersViewController.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 03/03/2025.
//

import UIKit

class ReviewersViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var collectionView: UICollectionView!
    ///
    private var viewModel: ReviewerViewModel
    private var sections: [CollectionViewDataSource] = []
    private var sectionsLayout: [LayoutSectionProvider] = []
    
    // MARK: - Init
    init(viewModel: ReviewerViewModel) {
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
        configureLayoutSections()
    }
}
// MARK: - Configuration
//
extension ReviewersViewController {
    private func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    private func configureSections() {
        let reviewrs = ReviewerCollectionViewSection(reviewers: viewModel.reviersItems)
        sections = [reviewrs]
        sections.forEach({ $0.registerCells(in: collectionView)})
    }
    private func configureLayoutSections() {
        let reviewers = ReviewerCollectionViewLayoutSection()
        sectionsLayout = [reviewers]
        
        let layoutFactory = SectionsLayout(providers: sectionsLayout)
        
        collectionView.setCollectionViewLayout(layoutFactory.createLayout(), animated: true)
    }
}
// MARK: - UICollectionViewDataSource
extension ReviewersViewController: UICollectionViewDataSource {
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
        if kind == HeaderView.headerIdentifier,
           let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: HeaderView.headerIdentifier,
            withReuseIdentifier: HeaderView.headerIdentifier,
            for: indexPath) as? HeaderView {
            header.configure(
                title: "Reviews Client",
                description: "",
                titleFont: .title3,
                shouldShowButton: false)
            return header
        }
        return UICollectionReusableView()
    }
}
// MARK: - UICollectionViewDelegate
//
extension ReviewersViewController: UICollectionViewDelegate {}
    
