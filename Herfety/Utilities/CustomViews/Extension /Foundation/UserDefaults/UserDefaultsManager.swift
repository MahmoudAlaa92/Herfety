//
//  UserDefaultsManager.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 22/08/2025.
//

import Foundation

/// Centralized UserDefaults manager using property wrappers
final class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    @UserDefault(key: \.login)
    var isLoggedIn: Bool?
    
    @UserDefault(key: \.userId)
    var userId: Int?
    
    @UserDefault(key: \.userInfo)
    var userInfo: RegisterUser?
    
    private init() {}
    
    /// Clear all user-related data
    func clearUserData() {
        let keys = [
            UserDefaultsKeys.shared.login,
            UserDefaultsKeys.shared.userId,
            UserDefaultsKeys.shared.userInfo
        ]
        
        UserDefaults.standard.reset(keys: keys) {}
    }
}
