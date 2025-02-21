//
//  CardView.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 20/02/2025.
//

import UIKit

class CardView: UIView {

    @IBOutlet weak var backGroundImage: UIImageView!
    @IBOutlet weak var nameCard: UILabel!
    @IBOutlet weak var imageCard: UIImageView!
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var cardNumber: UILabel!
    @IBOutlet weak var cardHolderName: UILabel!
    @IBOutlet weak var holderName: UILabel!
    @IBOutlet weak var validDateLabel: UILabel!
    @IBOutlet weak var validDateNumber: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
        configureUI()
        configureLabelUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNib()
        configureUI()
        configureLabelUI()
    }
    
    private func loadNib() {
        if let view = Bundle.main.loadNibNamed(String(describing: Self.self), owner: self)?.first as? UIView {
            addSubview(view)
            view.frame = bounds
        }
    }
}
// MARK: - Configuration
//
extension CardView {
    
    private func configureUI() {
        backGroundImage.image = Images.creditCredit1
        backGroundImage.contentMode = .scaleAspectFill
        backGroundImage.layer.cornerRadius = 15
    }
    
    private func configureLabelUI() {
        configureText(nameCard, text: nil, textColor: Colors.buttonGray, font: .title2)
        configureText(cardNumberLabel, text: "Card Number", textColor: Colors.hMainTheme, font: .body)
        configureText(cardNumber, text: nil, textColor: Colors.buttonGray, font: .title2)
        configureText(cardHolderName, text: "Card Holder Name", textColor: Colors.hMainTheme, font: .body)
        configureText(holderName, text: nil, textColor: Colors.buttonGray, font: .calloutBold)
        configureText(validDateLabel, text: "Valid Thru", textColor: Colors.hMainTheme, font: .body)
        configureText(validDateNumber, text: nil, textColor: Colors.buttonGray, font: .calloutBold)
        
    }
    
    private func configureText(_ label: UILabel, text: String?, textColor: UIColor, font: UIFont?) {
        label.text = text
        label.font = font
        label.textColor = textColor
    }
    
    func setCardNumber(number: String){
        
        cardNumber.text  = insertSpace(in: number)
        
        if number.isEmpty {
            imageCard.image = UIImage()
            nameCard.text = ""
        } else if number.hasPrefix("4") || number.hasPrefix("3") {
            imageCard.image = Images.creditVisa
            backGroundImage.image = Images.creditCredit3
            nameCard.text = "VISA"
        } else if number.hasPrefix("5") || number.hasPrefix("8") {
            imageCard.image = Images.creditMastercard
            backGroundImage.image = Images.creditCredit2
            nameCard.text = "MasterCard"
        } else if number.hasPrefix("6") || number.hasPrefix("7") {
            imageCard.image = Images.creditPaypal
            backGroundImage.image = Images.creditCredit4
            nameCard.text = "PAYPAl"
        } else if number.hasPrefix("1") || number.hasPrefix("2") {
            imageCard.image = Images.creditAmeri
            backGroundImage.image = Images.creditCredit1
            nameCard.text = "AMERICAN EXPRESS"
        }
    }
    
    private func insertSpace(in text: String) -> String {
        var result = ""
        for (index, chr) in text.enumerated() {
            if index % 4 == 0 && index != 0 {
                result.append(" ")
            }
            result.append(chr)
        }
        return result
    }
    
    func setValueDate(date: String) {
        validDateNumber.text = date
    }
    
    func setCardHolderName(name: String){
        holderName.text = name.uppercased()
    }
    
}
