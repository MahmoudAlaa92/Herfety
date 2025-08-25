//
//  ProfileListViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 06/03/2025.
//

import UIKit

class ProfileListViewModel {
    
    var firstList: [ProfileListItem] = [
        ProfileListItem(title: L10n.Profile.myOrder, icon: Images.iconMyCard),
        ProfileListItem(title: L10n.Profile.myFavourites, icon: Images.iconMyFavourites),
        ProfileListItem(title: L10n.Profile.shippingAddress, icon: Images.iconShippingAddress),
        ProfileListItem(title: L10n.Profile.myCard, icon: Images.iconCart),
        ProfileListItem(title: L10n.Profile.setting, icon: Images.iconSettings),
        ProfileListItem(title: L10n.Profile.logout, icon: Images.iconPersonalDetails),
    ]
    
    var secondList: [ProfileListItem] = [
        ProfileListItem(title: L10n.Profile.faqs, icon: Images.iconFAQs),
        ProfileListItem(title: L10n.Profile.privacyPolicy, icon: Images.iconPrivacyPolicy)
    ]
}
