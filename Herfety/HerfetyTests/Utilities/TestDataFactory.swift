//
//  TestDataFactory.swift
//  HerfetyTests
//
//  Created by Mahmoud Alaa on 18/08/2025.
//

import Foundation
@testable import Herfety

// MARK: - Test Data Factory
struct TestDataFactory {
    static func createMockCategories() -> [CategoryElement] {
        return [
            CategoryElement(
                id: 92,
                name: "Mahmoud Alaa",
                slug: "https",
                icon: "\(Images.artLogo)",
                status: 1,
                createdAt: "2025/08/17",
                updatedAt: "Today"
            )
        ]
    }

    static func createMockProducts() -> [Products] {
        return [
            Products(
                id: 1,
                name: "Silver Ring",
                slug: "https",
                thumbImage: "https",
                vendorID: 1,
                categoryID: 1,
                brandID: 1,
                qty: 1,
                shortDescription: "",
                longDescription: "",
                sku: "",
                price: 0.0,
                offerPrice: nil,
                offerStartDate: nil,
                offerEndDate: nil,
                productType: nil,
                isApproved: nil,
                seoTitle: nil,
                seoDescription: nil,
                createdAt: nil,
                updatedAt: nil
            )
        ]
    }

    static func createMockSliderItems() -> [SliderItem] {
        return [
            .init(
                name: "Wear Art, Wear You",
                description:
                    "Discover Unique Handmade Treasures for Your Journey!",
                offer: "UP to 10% OFF",
                image: Images.sliderImage1
            ),
            .init(
                name: "Own Style, Own Story",
                description:
                    "Discover Unique Handmade Treasures for Your Journey!",
                offer: "UP to 20% OFF",
                image: Images.chain
            ),
            .init(
                name: "Dress Bold, Live True",
                description:
                    "Discover Unique Handmade Treasures for Your Journey!",
                offer: "UP to 30% OFF",
                image: Images.imageOfArt
            ),
            .init(
                name: "Be Unique, Be You",
                description:
                    "Discover Unique Handmade Treasures for Your Journey!",
                offer: "UP to 40% OFF",
                image: Images.jewelry
            ),
        ]
    }

    static func createMockAlert() -> AlertModel {
        return AlertModel(
            message: "Test Alert",
            buttonTitle: "OK",
            image: .success,
            status: .success
        )
    }
}
