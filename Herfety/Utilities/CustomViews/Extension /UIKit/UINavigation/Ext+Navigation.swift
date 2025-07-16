//
//  Ext+Navigation.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 16/07/2025.
//

import UIKit

enum NavigationTransitionType {
    case push, fade
}

extension UINavigationController {
    func transition(to viewController: UIViewController, with type: NavigationTransitionType, subtype: CATransitionSubtype = .fromRight, duration: CFTimeInterval = 0.6) {
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

        view.layer.add(transition, forKey: kCATransition)
        pushViewController(viewController, animated: false)
    }
}
