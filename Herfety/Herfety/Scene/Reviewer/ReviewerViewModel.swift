//
//  ReviewerViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 03/03/2025.
//

import UIKit

class ReviewerViewModel {
    var reviersItems: [Reviewer] = [
        Reviewer(name: "Mahmoud Alaa",
                 image: Images.profilePhoto,
                 rating: 4,
                 date: "20 june, 2021",
                 comment: "The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using."),
        Reviewer(name: "Abdallah Mohamed",
                 image: Images.profilePhoto,
                 rating: 3,
                 date: "20 june, 2021",
                 comment: "The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using."),
        Reviewer(name: "Zyad Ahmed",
                 image: Images.profilePhoto,
                 rating: 1,
                 date: "20 june, 2021",
                 comment: "The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using.")
    ]
}
