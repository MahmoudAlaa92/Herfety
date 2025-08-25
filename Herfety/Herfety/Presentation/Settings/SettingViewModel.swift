//
//  SettingViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 02/04/2025.
//

import Foundation

class SettingViewModel {
    
    var onLogout: (() -> Void)?
    
    var firstList: [SettingItem] = [
        SettingItem(name: L10n.Settings.name),
        SettingItem(name: L10n.Settings.age),
        SettingItem(name: L10n.Settings.email),
    ]
    
    var secondList : [ProfileListItem] = [
        ProfileListItem(title: L10n.Settings.language, icon: Images.iconMyCard),
        ProfileListItem(title: L10n.Settings.notification, icon: Images.iconMyCard),
        ProfileListItem(title: L10n.Settings.helpCenter, icon: Images.iconMyCard),
    ]
}
