//
//  Ext+Window.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 21/07/2025.
//

import UIKit

extension UIWindow {
    func setRootViewController(_ viewController: UIViewController,
                               with type: NavigationTransitionType = .push,
                               subtype: CATransitionSubtype = .fromRight,
                               duration: CFTimeInterval = 0.6) {
        
        let transition = CATransition()
        transition.duration = duration
        transition.type = {
            switch type {
            case .push: return .push
            case .fade: return .fade
            }
        }()
        transition.subtype = subtype
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        layer.add(transition, forKey: kCATransition)
        rootViewController = viewController
        makeKeyAndVisible()
    }
}
