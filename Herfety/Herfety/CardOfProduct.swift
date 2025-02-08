//
//  CardOfProduct.swift
//  UIHerfety
//
//  Created by Mahmoud Alaa on 04/02/2025.
//

import UIKit

class CardOfProduct: UIView {

    @IBOutlet weak var offerStackView: UIStackView!
    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var nameProduct: UILabel!
    @IBOutlet weak var priceProduct: UILabel!
    @IBOutlet weak var offerPrice: UILabel!
    @IBOutlet weak var savePrice: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        laodNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        laodNib()
    }
    
    private func laodNib() {
        let view = Bundle.main.loadNibNamed(String(describing: Self.self), owner: self, options: nil)!.first as! UIView
        addSubview(view)
        view.frame = bounds
    }
    
}
