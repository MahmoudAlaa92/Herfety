//
//  ProfileDataSource.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 22/08/2025.
//

import Foundation
import UIKit

final class ProfileDataSource: ProfileDataSourceProtocol {
    private let userDataProvider: UserDataProvider
    private let profileListProvider: ProfileListProvider
    
    init(userDataProvider: UserDataProvider = UserDataProvider(),
         profileListProvider: ProfileListProvider = ProfileListProvider()) {
        self.userDataProvider = userDataProvider
        self.profileListProvider = profileListProvider
    }
    
    func fetchProfileData() async throws -> ProfileData {
        let nameData = await userDataProvider.getUserNameData()
        
        return ProfileData(
            nameData: nameData,
            firstListItems: getFirstListItems(),
            secondListItems: getSecondListItems()
        )
    }
    
    func getFirstListItems() -> [ProfileListItem] {
        return profileListProvider.getFirstListItems()
    }
    
    func getSecondListItems() -> [ProfileListItem] {
        return profileListProvider.getSecondListItems()
    }
}
