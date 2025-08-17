//
//  ProfileListViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 06/03/2025.
//

import UIKit

class ProfileListViewModel {
    
    var firstList: [ProfileListItem] = [
        ProfileListItem(title: "My Order", icon: Images.iconMyCard),
        ProfileListItem(title: "My Favourites", icon: Images.iconMyFavourites),
        ProfileListItem(title: "Shipping Address", icon: Images.iconShippingAddress),
        ProfileListItem(title: "My Card", icon: Images.iconCart),
        ProfileListItem(title: "Setting", icon: Images.iconSettings),
        // TODO: change this
        ProfileListItem(title: "Logout", icon: Images.iconPersonalDetails),
    ]
    
    var secondList: [ProfileListItem] = [
        ProfileListItem(title: "FAQs", icon: Images.iconFAQs),
        ProfileListItem(title: "Privacy Policy", icon: Images.iconPrivacyPolicy),
    ]
}
