//
//  UserDataProvider.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 22/08/2025.
//

import UIKit

final class UserDataProvider {
    
    let dataStore: DataStoreProtocol
    
    init(dataStore: DataStoreProtocol = DataStore.shared){
        self.dataStore = dataStore
    }
    
    func getUserNameData() async -> UserProfile {
        let info = await dataStore.getUserInfo()
        let userImage = await dataStore.getUserProfileImage()
        
        return UserProfile(
            name: info?.UserName ?? "",
            email: info?.Email ?? "",
            image: Images.profilePhoto // userImage
        )
    }
}
