//
//  CustomeTabBarViewController.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 09/02/2025.
//

import UIKit

class CustomeTabBarViewController: UITabBarController {

    var tabItem = UITabBarItem()
    
    var homeViewController: UIViewController!
    var wishListViewController: UIViewController!
    var cartViewController: UIViewController!
    var profileViewController: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let vc1 = UINavigationController(rootViewController: HomeViewController())
//        homeViewController = vc1
//        
//        let vc2 =  WishListViewController()
//        wishListViewController = vc2
//        
//        let vc3 = UINavigationController(rootViewController: OrderViewController())
//        cartViewController = vc3
//        
//        let vc4 = UINavigationController(rootViewController: ProfileViewController(nameViewModel: NameViewModel(), profileListViewModel: ProfileListViewModel()))
//        profileViewController = vc4
//        
//        viewControllers = [homeViewController, wishListViewController, cartViewController, profileViewController]
        
        setUpViews()
//        createCustomTabBar()
    }
}
// MARK: - Configurations
//
extension CustomeTabBarViewController {
    func setUpViews(){
        self.tabBar.layer.masksToBounds = true
        self.tabBar.isTranslucent = true
        self.tabBar.barTintColor = .white
        self.tabBar.layer.cornerRadius = 40
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.tabBar.layer.borderWidth = 0.5
        self.tabBar.layer.borderColor = Colors.labelGray.cgColor
    }
    
    func createCustomTabBar(){
        customTab(selectedImage: Images.homeSelected, deselectedImage: Images.homeIcon, indexOfTab: 0, tabTitle: "")
        customTab(selectedImage: Images.wishlistSelected, deselectedImage: Images.heartIcon, indexOfTab: 1, tabTitle: "")
        customTab(selectedImage: Images.cartSelected, deselectedImage: Images.cartIcon, indexOfTab: 2, tabTitle: "")
        customTab(selectedImage: Images.profileSelected, deselectedImage: Images.profileIcon, indexOfTab: 3, tabTitle: "")
    }
    
    func customTab(selectedImage image1 : UIImage , deselectedImage image2: UIImage , indexOfTab index: Int , tabTitle title: String) {
     
        tabItem = self.tabBar.items![index]
        tabItem.image = image2.withRenderingMode(.alwaysOriginal)
        tabItem.selectedImage = image1.withRenderingMode(.alwaysOriginal)
        tabItem.title = .none
        tabItem.imageInsets.bottom = -20
    }
}
