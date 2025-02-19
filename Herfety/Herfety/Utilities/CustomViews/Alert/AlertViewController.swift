//
//  AlertViewController.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 17/02/2025.
//

import UIKit

class AlertViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var confirmBtn: PrimaryButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
    }

}
// MARK: - Configuration
//
extension AlertViewController {
    
    private func setUp() {
      
        imageView.contentMode = .scaleAspectFill
        
        statusLabel.font = .title3
        
        descriptionLabel.font = .body
        descriptionLabel.numberOfLines = 0
        
    }
}
