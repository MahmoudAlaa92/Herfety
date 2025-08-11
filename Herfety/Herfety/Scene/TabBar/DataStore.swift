//
//  DataStore.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 07/08/2025.
//

import UIKit
import Combine

// MARK: - Publisher Manager (MainActor isolated)

class AppDataStorePublisher: ObservableObject {
    static let shared = AppDataStorePublisher()
    
    @Published var wishlistUpdated: Bool = false
    @Published var ordersUpdated: Bool = false
    @Published var cartUpdated: Bool = false
    @Published var loginStatusUpdated: Bool = false
    
    private init() {}
    
    func notifyWishlistUpdate(value: Bool) {
        wishlistUpdated = value
    }
    
    func notifyOrdersUpdate() {
        ordersUpdated.toggle()
    }
    
    func notifyCartUpdate(value: Bool) {
        cartUpdated = value
    }
    
    func notifyLoginStatusUpdate() {
        loginStatusUpdated.toggle()
    }
}

actor DataStore {
    static let shared = DataStore()
    
    // MARK: - Thread-safe UserDefaults access
    private var _login: Bool = false
    private var userInfo: RegisterUser?
    private var userId: Int = 22
    
    // MARK: - Private state (thread-safe within actor)
    private var userProfileImage: UIImage = Images.iconPersonalDetails
    private var isLogin: Bool = false
    private var orders: [WishlistItem] = []
    private var cartItems: [Wishlist] = []
    private var wishlist: [Wishlist] = []
    private var infos: [InfoModel] = []
    private var countProductDetails: Int = 1
    private var totalPriceOfOrders: Int = 0
    private var orderAddress: String = "Egypt, Aswan"
    
    // MARK: - Data actor for API operations
    private let dataActor = DataActor()
    
    init() {
        Task {
            await loadUserDefaultsSync()
            await fetchWishlistItems(id: userId, value: false)
            await loadUserProfileImage()
        }
    }
    
    // MARK: - Thread-safe UserDefaults access
    private func loadUserDefaultsSync() {
        // Synchronous UserDefaults access in init
        _login = UserDefaults.standard.bool(forKey: "login")
        if let userData = UserDefaults.standard.data(forKey: "userInfo"),
           let user = try? JSONDecoder().decode(RegisterUser.self, from: userData) {
            userInfo = user
        }
        isLogin = _login
    }
    
    private func saveUserDefaults() async {
        // Perform UserDefaults writes on a background queue to avoid blocking
        await withTaskGroup(of: Void.self) { group in
            group.addTask {
                await UserDefaults.standard.set(self._login, forKey: "login")
            }
            
            if let userInfo = self.userInfo {
                group.addTask {
                    if let userData = try? JSONEncoder().encode(userInfo) {
                        UserDefaults.standard.set(userData, forKey: "userInfo")
                    }
                }
            }
        }
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
    
    func getWishlist() -> [Wishlist] {
        return wishlist
    }
    
    func getCartItems() -> [Wishlist] {
        return cartItems
    }
    
    func getOrders() -> [WishlistItem] {
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
    
    func updateWishlist(_ newItems: [Wishlist] ,value: Bool) async {
        guard !newItems.isEmpty else { return }
        wishlist = newItems
        
        // Synchronous notification to ensure data consistency
        await MainActor.run {
            AppDataStorePublisher.shared.notifyWishlistUpdate(value: value)
        }
    }
    
    func updateCartItems(_ newItems: [Wishlist] ,value: Bool) async {
        cartItems = newItems
        calculateTotalPrice()
        
        await MainActor.run {
            AppDataStorePublisher.shared.notifyCartUpdate(value: value)
        }
    }
    
    func updateOrders(_ newOrders: [WishlistItem]) async {
        orders = newOrders
        
        await MainActor.run {
            AppDataStorePublisher.shared.notifyOrdersUpdate()
        }
    }
    
    func updateInfos(_ newInfos: [InfoModel]) async {
        infos = newInfos
    }
    
    func updateUserProfileImage(_ image: UIImage) async {
        userProfileImage = image
    }
    
    func updateLoginStatus(_ status: Bool) async {
        isLogin = status
        _login = status
        await saveUserDefaults()
        
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
    func fetchWishlistItems(id: Int = 22 ,value: Bool) async {
        do {
            let products = try await dataActor.fetchWishlistProducts(userId: id)
            await updateWishlist(products, value: value)
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
                    AppDataStorePublisher.shared.notifyWishlistUpdate(value: false)
                }
            }
        } catch {
            print("❌ Error deleting wishlist item: \(error)")
        }
    }
    
    func addToWishlist(userId: Int, productId: Int) async {
        do {
            try await dataActor.addWishlistProduct(userId: userId, productId: productId)
            await fetchWishlistItems(id: userId, value: true)
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
        _login = false
        
        await saveUserDefaults()
        
        await MainActor.run {
            let publisher = AppDataStorePublisher.shared
            publisher.notifyWishlistUpdate(value: true)
            publisher.notifyOrdersUpdate()
            publisher.notifyCartUpdate(value: true)
            publisher.notifyLoginStatusUpdate()
        }
    }
    
    // MARK: - Private Helper Methods
    private func calculateTotalPrice() {
        totalPriceOfOrders = cartItems.reduce(0) { total, item in
            total + Int((item.price ?? 0) * Double(item.qty ?? 1))
        }
    }
}

// MARK: - Publisher Extensions
extension AppDataStorePublisher {
    var wishlistUpdatePublisher: AnyPublisher<Bool, Never> {
        $wishlistUpdated.eraseToAnyPublisher()
    }
    
    var ordersUpdatePublisher: AnyPublisher<Bool, Never> {
        $ordersUpdated.eraseToAnyPublisher()
    }
    
    var cartUpdatePublisher: AnyPublisher<Bool, Never> {
        $cartUpdated.eraseToAnyPublisher()
    }
    
    var loginStatusPublisher: AnyPublisher<Bool, Never> {
        $loginStatusUpdated.eraseToAnyPublisher()
    }
}
// MARK: - Data Actor (Thread-safe)
//
actor DataActor {
    private let productService: ProductsOfWishlistRemoteProtocol
    
    init() {
        self.productService = ProductsOfWishlistRemote(network: AlamofireNetwork())
    }
    
    func fetchWishlistProducts(userId: Int) async throws -> [Wishlist] {
        return try await productService.loadAllProducts(userId: userId)
    }
    
    func removeWishlistProduct(userId: Int, productId: Int) async throws {
        _ = try await productService.removeProduct(userId: userId, productId: productId)
    }
    
    func addWishlistProduct(userId: Int, productId: Int) async throws {
        _ = try await productService.addNewProduct(userId: userId, productId: productId)
    }
}

