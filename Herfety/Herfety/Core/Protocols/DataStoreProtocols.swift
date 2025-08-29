//
//  DataStoreProtocols.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 07/08/2025.
//

import UIKit
import Foundation

// MARK: - Data Store Protocol
protocol DataStoreProtocol: Actor {
    // MARK: - Getters
    func getUserId() -> Int
    func getIsLogin() -> Bool
    func getUserInfo() -> RegisterUser?
    func getUserProfileImage() -> UIImage
    func getWishlist() -> [WishlistItem]
    func getCartItems() -> [WishlistItem]
    func getOrders() -> [OrderItem]
    func getInfos() -> [InfoModel]
    func getCountProductDetails() -> Int
    func getTotalPriceOfOrders() -> Int
    func getOrderAddress() -> String
    
    // MARK: - Setters
    func updateUserId(userId: Int)
    func updateUserInfo(userInfo: RegisterUser)
    func updateWishlist(_ newItems: [WishlistItem], showAlert: Bool) async
    func updateCartItems(_ newItems: [WishlistItem], showAlert: Bool) async
    func updateOrders(_ newOrders: [OrderItem]) async
    func updateInfos(_ newInfos: [InfoModel]) async
    func updateUserProfileImage(_ image: UIImage) async
    func updateLoginStatus(_ status: Bool) async
    func updateOrderAddress(_ address: String) async
    func updateTotalPriceOfOrders(value: Int) async
    
    // MARK: - Operations
    func incrementProductCount() -> Int
    func decrementProductCount() -> Int
    func fetchWishlistItems(id: Int, showAlert: Bool) async
    func deleteWishlistItem(userId: Int, productId: Int, indexPath: IndexPath) async
    func addToWishlist(userId: Int, productId: Int) async
    func loadUserProfileImage() async
    func logout() async
    
    // MARK: - Query Methods
    func isItemInWishlist(productId: Int) -> Bool
    func isItemInCart(productId: Int) -> Bool
    func isItemInInfos(addressInfo: InfoModel) -> Bool
}

// MARK: - Data Actor Protocol
protocol DataActorProtocol: Actor {
    func fetchWishlistProducts(userId: Int) async throws -> [WishlistItem]
    func removeWishlistProduct(userId: Int, productId: Int) async throws
    func addWishlistProduct(userId: Int, productId: Int) async throws
}

// MARK: - Products Wishlist Remote Protocol
protocol GetProductsOfWishlistRemoteProtocol {
    func loadAllProducts(userId: Int) async throws -> [WishlistItem]
    func removeProduct(userId: Int, productId: Int) async throws -> Bool
    func addNewProduct(userId: Int, productId: Int) async throws -> Bool
}

// MARK: - User Defaults Manager Protocol
protocol UserDefaultsManagerProtocol {
    var isLoggedIn: Bool? { get set }
    var userId: Int? { get set }
    var userInfo: RegisterUser? { get set }
    
    func clearUserData()
}
