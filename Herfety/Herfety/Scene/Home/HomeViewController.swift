//
//  HomeViewController.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 04/02/2025.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    private let viewModel = HomeViewModel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        cofigureCompositianalLayout()
    }
    
    private func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "SliderImagesCollectionViewCell", bundle: nil),forCellWithReuseIdentifier: SliderImagesCollectionViewCell.cellIdentifier)
        collectionView.register(UINib(nibName: "CategoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: CategoriesCollectionViewCell.cellIdentifier)
        
        
        collectionView.register(UINib(nibName: "HeaderView", bundle: nil),
                                forSupplementaryViewOfKind: "Header",
                                withReuseIdentifier: HeaderView.headerIdentifier)
    }
}

// MARK: - Configure Layout
extension HomeViewController {
    private func cofigureCompositianalLayout() {
        let layout = UICollectionViewCompositionalLayout { sectoinIndex, environment in
            switch sectoinIndex {
            case 0:
                return HomeLayout.createSliderSection()
            case 1:
                return HomeLayout.createCategoriesSection()
            default:
                return HomeLayout.createCategoriesSection()
            }
        }
        self.collectionView.setCollectionViewLayout(layout, animated: true)
    }
}

// MARK: - Configuration
//

// MARK: - UICollectionViewDelegate
//
extension HomeViewController: UICollectionViewDelegate {}

// MARK: - UICollectionViewDataSource
//
extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return viewModel.sliderItems.count
        case 1:
            return viewModel.categoryItems.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch HomeSection(rawValue: indexPath.section) {
        case .slider:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SliderImagesCollectionViewCell.cellIdentifier, for: indexPath) as? SliderImagesCollectionViewCell else { return UICollectionViewCell()}
            cell.topLabel.text = viewModel.sliderItems[indexPath.row].description
            cell.middleLabel.text = viewModel.sliderItems[indexPath.row].name
            cell.bottomLabel.text = viewModel.sliderItems[indexPath.row].offer
            cell.rightImage.image = viewModel.sliderItems[indexPath.row].image
            return cell
        case .categories:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.cellIdentifier, for: indexPath) as? CategoriesCollectionViewCell  else {
                return UICollectionViewCell()
            }
            
            cell.imageOfCategory.image = viewModel.categoryItems[indexPath.row].image
            cell.nameOfCategory.text = viewModel.categoryItems[indexPath.row].name
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    // MARK: - Header And Footer
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        
        if kind == "Header" {
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HeaderView.headerIdentifier,
                for: indexPath) as! HeaderView
            
            header.titleLabel.text = "the best deal on "
            header.descriptionLabel.text = "Jewelry & Accessories "
            return header
        }
        
        return UICollectionReusableView()
    }
    
}
