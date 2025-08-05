//
//  CustomeTabBarViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 18/04/2025.
//

import UIKit
import Combine

// MARK: - AsyncStream Events
enum WishlistUpdateEvent {
    case added(productId: Int)
    case removed(productId: Int)
}

enum OrdersUpdateEvent {
    case orderPlaced(orderId: Int)
    case orderCanceled(orderId: Int)
}

// MARK: - Modern Actor-based ViewModel with Safe Threading
@MainActor
class AppDataStore: ObservableObject {
    static let shared = AppDataStore()
    
    // MARK: - User Defaults Properties
    @UserDefault<Bool>(key: \.login) var login
    var userId: Int = 22
    @UserDefault<RegisterUser>(key: \.userInfo) var userInfo
    
    // MARK: - Subjects for reactive updates
    var isWishlistItemDeleted = CurrentValueSubject<Bool, Never>(false)
    var isOrdersItemDeleted = CurrentValueSubject<Bool, Never>(false)

    // MARK: - Published Properties (UI State) - MainActor Isolated
    @Published var userProfileImage: UIImage = Images.iconPersonalDetails
    @Published var isLogin: Bool = false
    @Published var orders: [WishlistItem] = []
    @Published var cartItems: [Wishlist] = []
    @Published var Wishlist: [Wishlist] = []
    @Published var infos: [InfoModel] = []
    @Published var countProductDetails: Int = 1
    @Published var totalPriceOfOrders: Int = 0
    @Published var orderAddress: String = "Egypt, Aswan"
    
    // MARK: - Thread-Safe Computed Properties for External Access
    nonisolated var isLoginValue: Bool {
        get async {
            await isLogin
        }
    }
    
    nonisolated var wishlistCount: Int {
        get async {
            await Wishlist.count
        }
    }
    
    nonisolated var cartItemsCount: Int {
        get async {
            await cartItems.count
        }
    }
    
    nonisolated var totalPrice: Int {
        get async {
            await totalPriceOfOrders
        }
    }
    
    var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Actor for thread-safe data operations
    private let dataActor = DataActor()
    
    init() {
        Task {
            await fetchWishlistItems(id: userId)
            await loadUserProfileImage()
        }
    }
    
    // MARK: - Public Methods
    func logout() {
        orders.removeAll()
        cartItems.removeAll()
        Wishlist.removeAll()
        isLogin = false
        login = false
    }
}
// MARK: - Data Actor for Thread-Safe Operations
//
actor DataActor {
    private let productService: ProductsOfWishlistRemoteProtocol
    
    init() {
        self.productService = ProductsOfWishlistRemote(network: AlamofireNetwork())
    }
    
    // MARK: - Wishlist Operations
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
// MARK: - Operations
//
extension AppDataStore {
    
    func fetchWishlistItems(id: Int = 22) async {
        do {
            let products = try await dataActor.fetchWishlistProducts(userId: id)
            self.Wishlist = products
        } catch {
            print("❌ Failed to fetch wishlist: \(error)")
        }
    }
    
    func deleteWishlistItem(userId: Int, productId: Int, indexPath: IndexPath) async {
        do {
            try await dataActor.removeWishlistProduct(userId: userId, productId: productId)
            
            if indexPath.row < Wishlist.count {
                Wishlist.remove(at: indexPath.row)
                isWishlistItemDeleted.send(true)
            }
        } catch {
            print("❌ Error deleting wishlist item: \(error)")
        }
    }
    
    func addToWishlist(userId: Int, productId: Int) async {
        do {
            try await dataActor.addWishlistProduct(userId: userId, productId: productId)
            await fetchWishlistItems(id: userId)
        } catch {
            print("❌ Error adding to wishlist: \(error)")
        }
    }
    
    func loadUserProfileImage() async {
        guard let imageUrl = userInfo?.image else {
            userProfileImage = Images.iconPersonalDetails
            return
        }
        
        if let loadedImage = await UIImage.load(from: imageUrl) {
            userProfileImage = loadedImage
        } else {
            userProfileImage = Images.iconPersonalDetails
        }
    }

}
// MARK: - Thread-Safe Update Methods
extension AppDataStore {
    
    func updateWishlist(_ newItems: [Wishlist]) {
        guard !newItems.isEmpty else { return }
        Wishlist = newItems
    }
    
    func updateCartItems(_ newItems: [Wishlist]) {
        cartItems = newItems
        calculateTotalPrice()
    }
    
    func updateOrders(_ newOrders: [WishlistItem]) {
        orders = newOrders
    }
    
    func incrementProductCount() {
        countProductDetails = min(countProductDetails + 1, 99)
    }
    
    func decrementProductCount() {
        countProductDetails = max(countProductDetails - 1, 1)
    }
    
    func updateProfileImage(_ image: UIImage) {
        userProfileImage = image
    }
    
    private func calculateTotalPrice() {
        totalPriceOfOrders = cartItems.reduce(0) { total, item in
            total + Int((item.price ?? 0) * Double(item.qty ?? 1))
        }
    }
}
// MARK: - Thread-Safe External Access Methods
extension AppDataStore {
    
    nonisolated func safeWishlistAccess() async -> [Wishlist] {
        await Wishlist
    }
    
    nonisolated func safeCartItemsAccess() async -> [Wishlist] {
        await cartItems
    }
    
    nonisolated func safeOrdersAccess() async -> [WishlistItem] {
        await orders
    }
    
    nonisolated func safeInfoAccess() async -> [InfoModel] {
        await infos
    }
    
    nonisolated func isItemInWishlist(productId: Int) async -> Bool {
        let wishlist = await Wishlist
        return wishlist.contains { $0.productID == productId }
    }
    
    nonisolated func isItemInCart(productId: Int) async -> Bool {
        let cart = await cartItems
        return cart.contains { $0.productID == productId }
    }
}
// MARK: - change this class to Actor (Safe threading)
//
class CustomeTabBarViewModel: ObservableObject {
    static let shared = CustomeTabBarViewModel()
    ///
    @UserDefault<Bool>(key: \.login) var login
    //    @UserDefault<Int>(key: \.userId) var userId
    var userId: Int = 22
    @UserDefault<RegisterUser>(key: \.userInfo) var userInfo
    
     var isWishlistItemDeleted = CurrentValueSubject<Bool, Never>(false)
     var isOrdersItemDeleted = CurrentValueSubject<Bool, Never>(false)
    ///
    @Published var userProfileImage: UIImage = Images.iconPersonalDetails
    @Published var isLogin: Bool = false
    @Published var orders: [WishlistItem] = []
    @Published var cartItems: [Wishlist] = []
    @Published var Wishlist: [Wishlist] = []
    @Published var infos: [InfoModel] = []
    
    @Published var countProductDetails: Int = 1
    @Published var totalPriceOfOrders: Int = 0
    ///
    @Published var orderAddress: String = "Egypt, Aswan"
    var subscriptions = Set<AnyCancellable>()
    ///
    func logout() {
        isLogin = false
        login = false
        orders.removeAll()
        cartItems.removeAll()
        Wishlist.removeAll()
    }
    
    init(){
        fetchWishlistItems(id: userId)
        loadUserProfileImage()
    }
}
// MARK: - Fetching
//
extension CustomeTabBarViewModel {
    // MARK: Wishlist
    func fetchWishlistItems(id: Int = 22) {
        let productItems: ProductsOfWishlistRemoteProtocol = ProductsOfWishlistRemote(network: AlamofireNetwork())
        Task {
            do {
                let products = try await productItems.loadAllProducts(userId: id)
                await MainActor.run {
                    self.Wishlist = products
                }
            } catch {
                print("❌ Failed to fetch wishlist: \(error)")
            }
        }
    }
}
// MARK: - Removing
//
extension CustomeTabBarViewModel {
    // MARK: Wishlist
    func deleteWishlistItem(userId: Int, productId: Int, indexPath: IndexPath) {
        let productItem: ProductsOfWishlistRemoteProtocol = ProductsOfWishlistRemote(network: AlamofireNetwork())
        
        Task {
            do {
                _ = try await productItem.removeProduct(userId: userId, productId: productId)
                _ = await MainActor.run {
                    self.Wishlist.remove(at: indexPath.row)
                }
            } catch {
                print("error \(error)")
            }
        }
    }
}
// MARK: - Private Handlers
//
extension CustomeTabBarViewModel {
    func loadUserProfileImage() {
        guard let imageUrl = userInfo?.image else {
            userProfileImage = Images.iconPersonalDetails
            return
        }
        
        Task {
            if let loadedImage = await UIImage.load(from: imageUrl) {
                userProfileImage = loadedImage
            } else {
                userProfileImage = Images.iconPersonalDetails
            }
        }
    }
}
