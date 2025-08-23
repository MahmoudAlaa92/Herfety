//
//  NameModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 05/03/2025.
//

import UIKit

struct ProfileData {
    let nameData: UserProfile
    let firstListItems: [ProfileListItem]
    let secondListItems: [ProfileListItem]
    
    static let empty = ProfileData(
        nameData: UserProfile(name: "", email: "", image: Images.iconPersonalDetails),
        firstListItems: [],
        secondListItems: []
    )
}

