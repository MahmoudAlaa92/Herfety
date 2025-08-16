//
//  PaymentView.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 11/02/2025.
//
import UIKit

class PaymentView: UIView {
    // MARK: - Outlets
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var subTotalLabel: UILabel!
    @IBOutlet weak var subTotalPrice: UILabel!
    
    @IBOutlet weak var shipingLabel: UILabel!
    @IBOutlet weak var shipingPrice: UILabel!
    
    @IBOutlet weak var TotalLabel: UILabel!
    @IBOutlet weak var TotalPrice: UILabel!
    
    @IBOutlet weak var numberOfItems: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNib()
    }
    
    /// Loads the view from a nib file and adds it as a subview to the PaymentView.
    private func loadNib() {
        let view = Bundle.main.loadNibNamed(String(String(describing: Self.self)), owner: self, options: nil)!.first as! UIView
        addSubview(view)
        view.frame = bounds
    }
}
// MARK: - ViewModel
//
extension PaymentView {
    /// The ViewModel structure for Payment. It represents the data required to display information in the user interface.
    struct Model {
        let subTotal: Double
        let shipping: Double
        let total: Double
        let numberOfItems: Int
    }
}
// MARK: - Configuration
//
extension PaymentView {
    /// Configures the PaymentView object with data from the ViewModel.
    ///
    /// - Parameter viewModel: The ViewModel containing the data to be displayed.
    func configure(with viewModel: PaymentView.Model) {
        self.subTotalPrice.text = "$" +  String(format: "%.2f",(viewModel.subTotal))
        self.subTotalPrice.font = .callout
        
        self.shipingPrice.text = "$\(viewModel.shipping)"
        self.shipingPrice.font = .callout
        
        self.TotalPrice.text = "$" +  String(format: "%.2f",(viewModel.total))
        self.TotalPrice.font = .callout
        
        self.numberOfItems.text = "(\(viewModel.numberOfItems) item)"
        self.numberOfItems.font = .body
        
        /// Constant
        subTotalLabel.text = "Sub Total :"
        subTotalLabel.font = .title3
        shipingLabel.text = "Shiping :"
        shipingLabel.font = .title3
        TotalLabel.text = "Total :"
        TotalLabel.font = .title3
        
        /// Style View
        numberOfItems.textColor = Colors.labelGray
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
        contentView.layer.borderColor = Colors.buttonGray.cgColor
    }
}
