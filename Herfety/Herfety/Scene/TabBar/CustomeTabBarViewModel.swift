//
//  CustomeTabBarViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 18/04/2025.
//

import UIKit
import Combine

enum TabBarItems: Int {
    case home = 0
    case wishlist
    case order
    case profile
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
    @Published var selectedTab: TabBarItems = .home
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
        selectedTab = .home
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
        productItems.loadAllProducts(userId: id) { [weak self] result in
            switch result {
            case.success(let products):
                DispatchQueue.main.async {
                    self?.Wishlist = products
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
    func deleteWishlistItem(userId: Int, productId: Int, indexPath: IndexPath) {
        let productItem = ProductsOfWishlistRemote(network: AlamofireNetwork())
        productItem.removeProduct(userId: userId, productId: productId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case.success(_):
                    self?.Wishlist.remove(at: indexPath.row)
                case .failure(let error):
                    print("error \(error)")
                }
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
