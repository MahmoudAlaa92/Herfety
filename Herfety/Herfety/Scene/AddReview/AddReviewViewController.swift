//
//  AddAdressViewController.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 17/02/2025.
//
import UIKit
import Combine

class AddReviewViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var AddReviewTextField: AddressTextField!
    @IBOutlet weak var addButton: PrimaryButton!
    // MARK: - Properties
    var viewModel: AddReviewViewModel
    // MARK: - Init
    init(viewModel: AddReviewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Lifcycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setUpuNavigationBar()
        configureTextFieldsPlaceholder()
    }
}
// MARK: - Configuration
//
extension AddReviewViewController {
    /// UI
    private func configureUI() {
        addButton.title = "Add"
    }
    /// Navigation Bar
    private func setUpuNavigationBar() {
        navigationItem.title = "Add Review"
    }
    /// Text Feild
    private func configureTextFieldsPlaceholder() {
        AddReviewTextField.placeholder = "Enter your Comment"
    }
}
// MARK: - Actions
//
extension AddReviewViewController {
    @IBAction func addPressed(_ sender: Any) {
        guard let name = AddReviewTextField.textField.text, !name.isEmpty
        else{
            return
        }
        let addComment = AddReview(review: name)
        
//        if !CustomeTabBarViewModel.shared.infos.contains(where: { $0 == addressValue }) {
//            CustomeTabBarViewModel.shared.infos.append(addressValue)
//        }
        self.navigationController?.popViewController(animated: true)
    }
}
