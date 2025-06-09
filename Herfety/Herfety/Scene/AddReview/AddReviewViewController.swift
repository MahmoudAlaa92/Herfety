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
    @IBOutlet weak var ratingTextField: AddressTextField!
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
        guard let review = AddReviewTextField.textField.text, !review.isEmpty,
              let rating = ratingTextField.textField.text, !rating.isEmpty
        else {
            return
        }
        let productId = viewModel.productId
        
        addReview(productId: productId, review: review, rating: rating)
        self.navigationController?.popViewController(animated: true)
    }
    
    private func getCurrentISODateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        formatter.timeZone = TimeZone(secondsFromGMT: 0) 
        return formatter.string(from: Date())
    }
    
    private func addReview(productId: Int, review: String, rating: String) {
        let createdAt = getCurrentISODateString()
        let c =  CreateReviewRequest(
            productId: productId,
            userId: CustomeTabBarViewModel.shared.userId ?? 1,
            review: review,
            rating: rating,
            status: 1,
            createdAt: createdAt)
        
        let createReview: ReviewRemoteProtocol = ReviewRemote(network: AlamofireNetwork())
        createReview.createReview(
            request: c
        ) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let review):
                    print("✅ Review added successfully: \(review)")
                    self?.showAlert(title: "Success", message: "Your review has been added.")
                    self?.navigationController?.popViewController(animated: true)
                case .failure(let error):
                    print("❌ Failed to add review: \(error.localizedDescription)")
                    self?.showAlert(title: "Error", message: "Failed to add review. Please try again.")
                }
            }
        }
    }
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

}
