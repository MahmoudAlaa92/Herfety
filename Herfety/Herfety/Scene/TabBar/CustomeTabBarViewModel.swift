//
//  CustomeTabBarViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 18/04/2025.
//

import Foundation
import Combine

enum TabBarItems: Int {
    case home = 0
    case wishlist
    case order
    case profile
}

class CustomeTabBarViewModel: ObservableObject {
    static let shared = CustomeTabBarViewModel()
    ///
    @UserDefault<Bool>(key: \.login) var login
    @UserDefault<Int>(key: \.userId) var userId
    ///
    @Published var selectedTab: TabBarItems = .home
    @Published var tabBarIsHidden: Bool = false
    @Published var isLogin: Bool = false
    @Published var orders: [WishlistItem] = []
    @Published var cartItems: [Wishlist] = []
    @Published var Wishlist: [Wishlist] = []
    @Published var infos: [InfoModel] = []
    @Published var countProductDetails: Int = 1
    ///
    var subscriptions = Set<AnyCancellable>()
    ///
    func logout() {
        selectedTab = .home
        isLogin = false
        login = false
        orders.removeAll()
        cartItems.removeAll()
        Wishlist.removeAll()
    }
    
    init(){
        fetchWishlistItems()
        userId = 1
    }
}

// MARK: - Fetching
//
extension CustomeTabBarViewModel {
    // MARK: Wishlist
    func fetchWishlistItems(id: Int = 1) {
        let productItems: ProductsOfWishlistRemote = ProductsOfWishlistRemote(network: AlamofireNetwork())
        productItems.loadAllProducts(userId: id) { result in
            switch result {
            case.success(let products):
                DispatchQueue.main.async {
                    self.Wishlist = products
                }
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
}
// MARK: - Removing
//
extension CustomeTabBarViewModel {
    // MARK: Wishlist
    func deleteWishlistItem(userId: Int, productId: Int) {
        let productItem = ProductsOfWishlistRemote(network: AlamofireNetwork())
        productItem.removeProduct(userId: userId, productId: productId) { result in
            DispatchQueue.main.async {
                switch result {
                case.success(_):
                    print("Deleted Succufuly")
                case .failure(let error):
                    print("error \(error)")
                }
            }
        }
    }
}
