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
    ///
    @Published var selectedTab: TabBarItems = .home
    @Published var tabBarIsHidden: Bool = false
    @Published var isLogin: Bool = false
    @Published var cart: [WishlistItem] = []
    @Published var orders: [Products] = []
    @Published var Wishlist: [Products] = []
    @Published var infos: [InfoModel] = []
    @Published var notificationsIsRead: Bool = false
    ///
    var subscriptions = Set<AnyCancellable>()
    ///
    func logout() {
        selectedTab = .home
        isLogin = false
        login = false
        cart.removeAll()
        orders.removeAll()
        Wishlist.removeAll()
    }
    
    init(){
        fetchWishlistItems()
    }
}

// MARK: - Fetching
//
extension CustomeTabBarViewModel {
    // MARK: Products of Categories
    func fetchWishlistItems(id: Int = 1) {
        let productItems: GetProductsOfWishlistRemote = GetProductsOfWishlistRemote(network: AlamofireNetwork())
        productItems.loadAllProducts(userId: id) { result in
            switch result {
            case.success(let products):
                DispatchQueue.main.async {
                    self.Wishlist = products
                    
                }
            case .failure(let error):
                assertionFailure("error here \(error)")
            }
        }
    }
}
