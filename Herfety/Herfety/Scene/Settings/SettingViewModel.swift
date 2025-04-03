//
//  SettingViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 02/04/2025.
//

import Foundation

class SettingViewModel {
    var firstList: [SettingItem] = [
        SettingItem(name: "Name"),
        SettingItem(name: "Age"),
        SettingItem(name: "Email"),
    ]
    
    var secondList : [ProfileListItem] = [
        ProfileListItem(title: "Language", icon: Images.iconMyCard),
        ProfileListItem(title: "Notification", icon: Images.iconMyCard),
        ProfileListItem(title: "Help Center", icon: Images.iconMyCard),
    ]
}
