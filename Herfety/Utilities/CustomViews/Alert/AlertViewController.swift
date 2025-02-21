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

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var confirmBtn: PrimaryButton!
    @IBOutlet weak var alertView: UIView!
    
    var actionHandler: ActionHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
}
// MARK: - Configuration
//
extension AlertViewController {
    
    private func setUpUI() {
      
        imageView.contentMode = .scaleAspectFill
        
        statusLabel.font = .title3
        
        descriptionLabel.font = .body
        descriptionLabel.numberOfLines = 0
        
        alertView.backgroundColor = Colors.labelGray.withAlphaComponent(0.2)
        alertView.layer.cornerRadius = 15
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
