//
//  ProfileViewModelFactory.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 22/08/2025.
//

import Foundation

final class ProfileViewModelFactory {
    static func create(coordinator: PorfileTransionDelegate?) -> ProfileViewModel {
        let userDataProvider = UserDataProvider()
        let profileListProvider = ProfileListProvider()
        let dataSource = ProfileDataSource(
            userDataProvider: userDataProvider,
            profileListProvider: profileListProvider
        )
        let sectionConfigurator = ProfileSectionConfigurator()
        
        return ProfileViewModel(
            dataSource: dataSource,
            sectionConfigurator: sectionConfigurator,
            coordinator: coordinator
        )
    }
}
