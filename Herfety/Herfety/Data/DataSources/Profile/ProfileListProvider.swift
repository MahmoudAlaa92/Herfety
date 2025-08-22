//
//  ProfileListProvider.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 22/08/2025.
//

import UIKit

final class ProfileListProvider {
    
    func getFirstListItems() -> [ProfileListItem] {
        return [
            ProfileListItem(title: "My Order", icon: Images.iconMyCard),
            ProfileListItem(title: "My Favourites", icon: Images.iconMyFavourites),
            ProfileListItem(title: "Shipping Address", icon: Images.iconShippingAddress),
            ProfileListItem(title: "My Card", icon: Images.iconCart),
            ProfileListItem(title: "Setting", icon: Images.iconSettings),
            ProfileListItem(title: "Logout", icon: Images.iconPersonalDetails),
        ]
    }
    
    func getSecondListItems() -> [ProfileListItem] {
        return [
            ProfileListItem(title: "FAQs", icon: Images.iconFAQs),
            ProfileListItem(title: "Privacy Policy", icon: Images.iconPrivacyPolicy),
        ]
    }
}
