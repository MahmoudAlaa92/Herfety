//
//  AddReviewViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 06/06/2025.
//

import Foundation

class AddReviewViewModel {
    var reviersItems: [Reviewrr]
    let productId: Int

    init(reviersItems: [Reviewrr], productId: Int) {
        self.reviersItems = reviersItems
        self.productId = productId
    }
}
