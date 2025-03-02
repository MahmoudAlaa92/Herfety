//
//  ProductDetailsViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 27/02/2025.
//

import Foundation

class ProductDetailsViewModel {
    var productItems: Product =
    Product(image: [Images.chain, Images.jewelry, Images.fashion],
            name: "Jewelary",
            price: "$200.00",
            review: 20,
            reviewCount: 108,
            availableCount: 100)
    
    var reviewsItems: [Review] = [
        Review(comment: "This Is Good", image: Images.profilePhoto),
        Review(comment: "This Is Good", image: Images.profilePhoto)
    ]
    
    var recommendItems: [ProductItem] = [
        ProductItem(name: "Jewelry", image: Images.chain, price: "$10499", discountPrice: "$14999", offerPrice: "30%", savePrice: "Save - $4500"),
        ProductItem(name: "Jewelry", image: Images.chain, price: "$10499", discountPrice: "$14999", offerPrice: "30%", savePrice: "Save - $4500"),
        ProductItem(name: "Jewelry", image: Images.chain, price: "$10499", discountPrice: "$14999", offerPrice: "30%", savePrice: "Save - $4500"),
        ProductItem(name: "Jewelry", image: Images.chain, price: "$10499", discountPrice: "$14999", offerPrice: "30%", savePrice: "Save - $4500"),
        ProductItem(name: "Jewelry", image: Images.chain, price: "$10499", discountPrice: "$14999", offerPrice: "30%", savePrice: "Save - $4500")
    ]
    
}
