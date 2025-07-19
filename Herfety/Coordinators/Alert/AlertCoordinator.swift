//
//  AlertCoordinator.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 12/07/2025.
//

import UIKit

protocol AlertPresenter: AnyObject {
    func showAlert(_ alert: AlertModel)
}

final class AlertCoordinator: AlertPresenter {
    
    private weak var rootViewController: UIViewController?
    
    init(presentingViewController: UIViewController) {
        self.rootViewController = presentingViewController
    }
    
    func showAlert(_ alert: AlertModel) {
        let alertVC = AlertViewController(nibName: "AlertViewController", bundle: nil)
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        alertVC.loadViewIfNeeded()
        
        alertVC.show(alertItem: alert)
        
        alertVC.actionHandler = { [weak alertVC] in
            alertVC?.dismiss(animated: true)
        }
        rootViewController?.presentAlertWithTransition(alertVC, type: .fade)
    }
}
