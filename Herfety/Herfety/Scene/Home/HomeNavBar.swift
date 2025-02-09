//
//  HomeNavBar.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 09/02/2025.
//

import UIKit
import UIHerfety

class HomeNavBar {
    
    private unowned var navigationItem: UINavigationItem
    private var noticationBtn: () -> Void = {}
    private var searchBtn: () -> Void = {}
    private var navigationBarButtonItems: [UIBarButtonItem] = []
    
    init(navigationItem: UINavigationItem) {
        self.navigationItem = navigationItem
    }
}

// MARK: - Configure
//
extension HomeNavBar {
    
    func configure(onNotification: @escaping () -> Void, onSearch: @escaping () -> Void, userName: String, userImage: UIImage) {
        self.noticationBtn = onNotification
        self.searchBtn = onSearch
        
        /// Container view
        let profileView = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 40))
        
        /// Image
        let imageView = UIImageView(frame: CGRect(x: 0, y: 5, width: 30, height: 30))
        imageView.image = userImage
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        /// Name of person
        let nameLabel = UILabel(frame: CGRect(x: 40, y: 5, width: 110, height: 30))
        nameLabel.text = userName
        nameLabel.textColor = .black
        nameLabel.font = .body
        

        // Add subviews
        profileView.addSubview(imageView)
        profileView.addSubview(nameLabel)
        
        // Create left bar button item
        let leftBarButtonItem = UIBarButtonItem(customView: profileView)
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        let searchButton = UIBarButtonItem(image: Images.search.withRenderingMode(.alwaysOriginal),
                                           style: .done,
                                           target: self,
                                           action: #selector(searchWasTapped))
        let notificationButton = UIBarButtonItem(image: Images.notification.withRenderingMode(.alwaysOriginal),
                                                 style: .done,
                                                 target: self,
                                                 action: #selector(notificationWasTapped))
        
        navigationBarButtonItems = [notificationButton, searchButton]
        navigationItem.rightBarButtonItems = navigationBarButtonItems
    }
    
}

// MARK: - Actions
//
extension HomeNavBar {
    
    @objc private func searchWasTapped() {
        noticationBtn()
    }
    
    @objc private func notificationWasTapped() {
        searchBtn()
    }
}
