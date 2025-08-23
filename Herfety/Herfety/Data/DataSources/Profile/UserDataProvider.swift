//
//  UserDataProvider.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 22/08/2025.
//

import UIKit

final class UserDataProvider {
    
    func getUserNameData() async -> UserProfile {
        let info = await DataStore.shared.getUserInfo()
        let userImage = await DataStore.shared.getUserProfileImage()
        
        return UserProfile(
            name: info?.UserName ?? "",
            email: info?.Email ?? "",
            image: userImage
        )
    }
}
