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
// MARK: - push pop present
//
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
    
    func pop(with type: NavigationTransitionType, subtype: CATransitionSubtype = .fromLeft, duration: CFTimeInterval = 0.6) {
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
        popViewController(animated: false)
    }
    
    func present(_ viewController: UIViewController,
                    with type: NavigationTransitionType,
                    subtype: CATransitionSubtype = .fromRight,
                    duration: CFTimeInterval = 0.6,
                    completion: (() -> Void)? = nil) {
           
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
           
           view.window?.layer.add(transition, forKey: kCATransition)
           viewController.modalPresentationStyle = .fullScreen
           present(viewController, animated: false, completion: completion)
       }
}
// MARK: - Alert
//
extension UIViewController {
    func presentAlertWithTransition(_ alertVC: UIViewController,
                                    type: NavigationTransitionType = .fade,
                                    subtype: CATransitionSubtype = .fromRight,
                                    duration: CFTimeInterval = 0.6,
                                    completion: (() -> Void)? = nil) {
        
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
        
        view.window?.layer.add(transition, forKey: kCATransition)
        
        alertVC.modalPresentationStyle = .overFullScreen
        present(alertVC, animated: false, completion: completion)
    }
}
