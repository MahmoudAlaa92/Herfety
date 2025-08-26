//
//  DataStoreService.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 07/08/2025.
//

import UIKit
import Foundation

// MARK: - Data Store Service
actor DataStore: DataStoreProtocol {
    static let shared = DataStore()
    
    // MARK: - Thread-safe UserDefaults access
    private var userInfo: RegisterUser?
    private var userId: Int = 22
    private var isLogin: Bool = false
    
    // MARK: - Private state (thread-safe within actor)
    private var userProfileImage: UIImage = Images.iconPersonalDetails
    private var orders: [OrderItem] = []
    private var cartItems: [WishlistItem] = []
    private var wishlist: [WishlistItem] = []
    private var infos: [InfoModel] = []
    private var countProductDetails: Int = 1
    private var totalPriceOfOrders: Int = 0
    private var orderAddress: String = "Egypt, Aswan"
    
    // MARK: - Dependencies
    private let dataActor: DataActorProtocol
    private var userDefaultsManager: UserDefaultsManagerProtocol
    
    // MARK: - Init
    init(
        dataActor: DataActorProtocol = DataActor(),
        userDefaultsManager: UserDefaultsManagerProtocol = UserDefaultsManager.shared
    ) {
        self.dataActor = dataActor
        self.userDefaultsManager = userDefaultsManager
        
        Task {
            await loadFromUserDefaults()
            await fetchWishlistItems(id: userId, showAlert: false)
        }
    }
    
    // MARK: - UserDefaults Integration
    private func loadFromUserDefaults() {
        isLogin = userDefaultsManager.isLoggedIn ?? false
        userId = userDefaultsManager.userId ?? 22
        userInfo = userDefaultsManager.userInfo
    }
    
    // MARK: - Safe External Access Methods
    func getUserId() -> Int {
        return userId
    }
    
    func getIsLogin() -> Bool {
        return isLogin
    }
    
    func getUserInfo() -> RegisterUser? {
        return userInfo
    }
    
    func getUserProfileImage() -> UIImage {
        return userProfileImage
    }
    
    func getWishlist() -> [WishlistItem] {
        return wishlist
    }
    
    func getCartItems() -> [WishlistItem] {
        return cartItems
    }
    
    func getOrders() -> [OrderItem] {
        return orders
    }
    
    func getInfos() -> [InfoModel] {
        return infos
    }
    
    func getCountProductDetails() -> Int {
        return countProductDetails
    }
    
    func getTotalPriceOfOrders() -> Int {
        return totalPriceOfOrders
    }
    
    func getOrderAddress() -> String {
        return orderAddress
    }
    
    // MARK: - Update Methods with Synchronous Notifications
    func updateUserId(userId: Int) {
        self.userId = userId
    }
    
    func updateUserInfo(userInfo: RegisterUser) {
        self.userInfo = userInfo
    }
    
    func updateWishlist(_ newItems: [WishlistItem], showAlert: Bool) async {
        guard !newItems.isEmpty else { return }
        wishlist = newItems
        
        // Synchronous notification to ensure data consistency
        await MainActor.run {
            AppDataStorePublisher.shared.notifyWishlistUpdate(showAlert: showAlert)
        }
    }
    
    func updateCartItems(_ newItems: [WishlistItem], showAlert: Bool) async {
        cartItems = newItems
        calculateTotalPrice()
        
        await MainActor.run {
            AppDataStorePublisher.shared.notifyCartUpdate(showAlert: showAlert)
        }
    }
    
    func updateOrders(_ newOrders: [OrderItem]) async {
        orders = newOrders
        
        await MainActor.run {
            AppDataStorePublisher.shared.notifyOrdersUpdate()
        }
    }
    
    func updateTotalPriceOfOrders(value: Int) {
        totalPriceOfOrders = value
    }
    
    func updateInfos(_ newInfos: [InfoModel]) async {
        infos = newInfos
        
        await MainActor.run {
            AppDataStorePublisher.shared.notifyInfoUpdate()
        }
    }
    
    func updateUserProfileImage(_ image: UIImage) async {
        userProfileImage = image
    }
    
    func updateLoginStatus(_ status: Bool) async {
        isLogin = status
        userDefaultsManager.isLoggedIn = status

        await MainActor.run {
            AppDataStorePublisher.shared.notifyLoginStatusUpdate()
        }
    }
    
    func updateOrderAddress(_ address: String) async {
        orderAddress = address
    }
    
    func incrementProductCount() -> Int {
        countProductDetails = min(countProductDetails + 1, 99)
        return countProductDetails
    }
    
    func decrementProductCount() -> Int {
        countProductDetails = max(countProductDetails - 1, 1)
        return countProductDetails
    }
    
    // MARK: - Query Methods
    func isItemInWishlist(productId: Int) -> Bool {
        return wishlist.contains { $0.productID == productId }
    }
    
    func isItemInCart(productId: Int) -> Bool {
        return cartItems.contains { $0.productID == productId }
    }
    
    func isItemInInfos(addressInfo: InfoModel) -> Bool {
        return infos.contains { $0 == addressInfo }
    }
    
    // MARK: - Operations
    func fetchWishlistItems(id: Int = 22, showAlert: Bool) async {
        do {
            let products = try await dataActor.fetchWishlistProducts(userId: id)
            await updateWishlist(products, showAlert: showAlert)
        } catch {
            print("❌ Failed to fetch wishlist: \(error)")
        }
    }
    
    func deleteWishlistItem(userId: Int, productId: Int, indexPath: IndexPath) async {
        do {
            try await dataActor.removeWishlistProduct(userId: userId, productId: productId)
            
            if indexPath.row < wishlist.count {
                wishlist.remove(at: indexPath.row)
                
                await MainActor.run {
                    AppDataStorePublisher.shared.notifyWishlistUpdate(showAlert: false)
                }
            }
        } catch {
            print("❌ Error deleting wishlist item: \(error)")
        }
    }
    
    func addToWishlist(userId: Int, productId: Int) async {
        do {
            try await dataActor.addWishlistProduct(userId: userId, productId: productId)
            await fetchWishlistItems(id: userId, showAlert: true)
        } catch {
            print("❌ Error adding to wishlist: \(error)")
        }
    }
    
    func loadUserProfileImage() async {
        guard let imageUrl = userInfo?.image else {
            userProfileImage = Images.iconPersonalDetails
            return
        }
        
        /// Ensure image loading is done on appropriate queue
        if let loadedImage = await loadImageSafely(from: imageUrl) {
            userProfileImage = loadedImage
        } else {
            userProfileImage = Images.iconPersonalDetails
        }
    }
    
    private func loadImageSafely(from url: String) async -> UIImage? {
        /// This should be implemented with proper error handling
        /// and background queue execution
        return await UIImage.load(from: url)
    }
    
    func logout() async {
        orders.removeAll()
        cartItems.removeAll()
        wishlist.removeAll()
        isLogin = false
        userId = 22
        userInfo = nil
        userDefaultsManager.clearUserData()
    }
    
    // MARK: - Private Helper Methods
    private func calculateTotalPrice() {
        totalPriceOfOrders = cartItems.reduce(0) { total, item in
            total + Int((item.price ?? 0) * Double(item.qty ?? 1))
        }
    }
}
