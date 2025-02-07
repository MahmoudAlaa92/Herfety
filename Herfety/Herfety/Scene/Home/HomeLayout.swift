//
//  HomeLayout.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 04/02/2025.
//

import UIKit

struct HomeLayout {
    
    //MARK: - Properties
    //
    private let layoutProviders: [SectionLayoutProvider]
    
    // MARK: - Init
    //
    init(providers: [SectionLayoutProvider]) {
        self.layoutProviders = providers
    }
    // MARK: - Configure
    //
    func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, _ in
            guard sectionIndex < self.layoutProviders.count else { return nil }
            
            return layoutProviders[sectionIndex].layoutSection()
        }
    }
    
}
