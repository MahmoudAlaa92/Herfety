//
//  HerfetyButton.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 13/02/2025.
//

import UIKit

class HerfetyButton: UIButton {
    
    var title: String? {
        get { titleLabel?.text }
        set { setTitle(newValue, for: .normal) }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    func setUp() {
       let height: CGFloat = 52
       setTitleColor(.white, for: .normal)
       layer.cornerRadius = 10
       heightAnchor.constraint(equalToConstant: height).isActive = true
       
       if #available(iOS 15.0, *) {
           configuration = nil
           imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 20)
           titleLabel?.font = .systemFont(ofSize: 16.0, weight: .bold)
       
       }
   }
}
