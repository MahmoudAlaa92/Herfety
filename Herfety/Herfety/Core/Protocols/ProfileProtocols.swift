//
//  ProfileProtocols.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 22/08/2025.
//

import UIKit
import Combine

// MARK: - Profile Module Protocols
protocol ProfileDataSourceProtocol {
    func fetchProfileData() async throws -> ProfileData
    func getFirstListItems() -> [ProfileListItem]
    func getSecondListItems() -> [ProfileListItem]
}

protocol ProfileSectionConfiguratorProtocol {
    func configureSections(
        profileData: ProfileData,
        coordinator: PorfileTransionDelegate?
    ) -> [CollectionViewDataSource]
    
    func configureLayoutSections() -> [LayoutSectionProvider]
}
