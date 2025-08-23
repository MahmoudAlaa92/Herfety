//
//  ProfileSectionConfigurator.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 22/08/2025.
//

import Foundation

final class ProfileSectionConfigurator: ProfileSectionConfiguratorProtocol {
    
    func configureSections(
        profileData: ProfileData,
        coordinator: PorfileTransionDelegate?
    ) -> [CollectionViewDataSource] {
        
        let nameSection = createNameSection(nameData: profileData.nameData)
        let firstListSection = createFirstListSection(
            items: profileData.firstListItems,
            coordinator: coordinator
        )
        let secondListSection = createSecondListSection(
            items: profileData.secondListItems,
            coordinator: coordinator
        )
        
        return [nameSection, firstListSection, secondListSection]
    }
    
    func configureLayoutSections() -> [LayoutSectionProvider] {
        return [
            NameCollectionViewLayoutSection(),
            ProfileListLayoutSection(),
            ProfileListLayoutSection()
        ]
    }
}
// MARK: - Private Section Creators
//
extension ProfileSectionConfigurator {
    private func createNameSection(nameData: UserProfile) -> NameOfProfileCollectionViewSection {
        return NameOfProfileCollectionViewSection(sectionName: nameData)
    }
    
    private func createFirstListSection(
        items: [ProfileListItem],
        coordinator: PorfileTransionDelegate?
    ) -> ProfileListCollectionViewSection {
        return ProfileListCollectionViewSection(
            items: items,
            coordinator: coordinator
        )
    }
    
    private func createSecondListSection(
        items: [ProfileListItem],
        coordinator: PorfileTransionDelegate?
    ) -> ProfileListCollectionViewSection {
        return ProfileListCollectionViewSection(
            items: items,
            coordinator: coordinator
        )
    }
}
