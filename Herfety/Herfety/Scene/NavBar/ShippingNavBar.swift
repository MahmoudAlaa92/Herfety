//
//  ShippingNavBar.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 14/02/2025.
//

import UIKit

class ShippingNavBar {
    
    // MARK: - Properties
    private unowned var navigationItem: UINavigationItem
    private unowned var navigationController: UINavigationController?
    private var navigationBarButtonItems: [UIBarButtonItem] = []
    private var plusBtn: () -> Void = {}
    
    // MARK: - Init
    init(navigationItem: UINavigationItem , navigationController: UINavigationController?) {
        self.navigationItem = navigationItem
        self.navigationController = navigationController
    }
}

// MARK: - Configure
//
extension ShippingNavBar {
    
    func configure(title: String = "", titleColor: UIColor = .black, onPlus: @escaping () -> Void) {
        self.plusBtn = onPlus
        
        let plusButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(onPlusBtnTapped))
        
        /// Set right button
        navigationBarButtonItems = [plusButton]
        navigationItem.rightBarButtonItems = navigationBarButtonItems
        
        /// Set title
        navigationItem.title = title
        
        /// Customize navigation bar appearance
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground
        appearance.titleTextAttributes = [.foregroundColor: titleColor, .font: UIFont.title2]
        
        ///Set backIndicatorImage inside the appearance
        appearance.setBackIndicatorImage(Images.iconBack.withRenderingMode(.alwaysOriginal),
                                         transitionMaskImage: Images.iconBack.withRenderingMode(.alwaysOriginal))
        /// Ensure navigationController is not nil

        if let navigationController = navigationController {
            navigationController.navigationBar.standardAppearance = appearance
            navigationController.navigationBar.scrollEdgeAppearance = appearance
            navigationController.navigationBar.compactAppearance = appearance
        }
    }
}

// MARK: - Actions
//
extension ShippingNavBar {
    @objc private func onPlusBtnTapped() {
        plusBtn()
    }
}
