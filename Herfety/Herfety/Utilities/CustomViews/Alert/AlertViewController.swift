//
//  AlertViewController.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 17/02/2025.
//

import UIKit

public protocol AlertInterface {
    func show(alertItem: AlertModel)
}
class AlertViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var confirmBtn: PrimaryButton!
    @IBOutlet weak var alertView: UIView!
    // MARK: - Properties
    var actionHandler: ActionHandler?
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
}
// MARK: - Configuration
//
extension AlertViewController {
    
    private func setUpUI() {
        view.backgroundColor = Colors.hSocialButton.withAlphaComponent(0.3)
        imageView.contentMode = .scaleAspectFill
        
        statusLabel.font = .title3
        
        descriptionLabel.font = .callout
        descriptionLabel.numberOfLines = 0
        
        alertView.backgroundColor = Colors.hPrimaryBackground
        alertView.layer.cornerRadius = 15
        alertView.layer.shadowColor = UIColor.gray.cgColor
        alertView.layer.shadowRadius = 10
        alertView.layer.shadowOpacity = 0.5
        
        confirmBtn.layer.cornerRadius = 15
    }
}
// Actions
//
extension AlertViewController: AlertInterface {
    
    @IBAction func pressedConfirmBtn(_ sender: Any) {
        actionHandler?()
    }
    
    func show(alertItem: AlertModel) {
        imageView.image = alertItem.status.image
        statusLabel.text = alertItem.status.title
        descriptionLabel.text = alertItem.message
        confirmBtn.setTitle(alertItem.buttonTitle, for: .normal)
        self.actionHandler = alertItem.buttonAction
    }
}
