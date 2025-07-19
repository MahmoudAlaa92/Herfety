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
    private var navBarBehavior: HerfetyNavigationController?
    private var cancellables = Set<AnyCancellable>()
    weak var coordinator: AddReviewsChildDelegate?
    
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
        setUpNavigationBar()
        configureUI()
        setUpuNavigationBar()
        configureTextFieldsPlaceholder()
        bindViewModel()
    }
}
// MARK: - Configuration
//
extension AddReviewViewController {
    /// NavBar
    private func setUpNavigationBar() {
        navBarBehavior = HerfetyNavigationController(
            navigationItem: navigationItem,
            navigationController: navigationController
        )
        navBarBehavior?.configure(
            title: "",
            titleColor: Colors.primaryBlue,
            onPlus: {
                /// don't add plus button in VC
            },
            showRighBtn: false,
            showBackButton: true,  /// Enable back button
            onBack: { [weak self] in
                self?.coordinator?.backToReviewersVC()
            }
        )
    }
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
        ratingTextField.placeholder = "Rating (1-5)"
        ratingTextField.textField.keyboardType = .numberPad
    }
}
// MARK: - Actions
//
extension AddReviewViewController {
    @IBAction func addPressed(_ sender: Any) {
        let reviewText = AddReviewTextField.textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
         let ratingText = ratingTextField.textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
         
         // Validate inputs
         guard
             !reviewText.isEmpty,
             !ratingText.isEmpty,
             let ratingValue = Int(ratingText),
             (1...5).contains(ratingValue)
         else {
             showAlert(title: "Invalid Input", message: "Please enter:\n- Review text\n- Rating between 1-5")
             return
         }
        viewModel.submitReview(review: reviewText, rating: ratingText)
    }
    
    private func showSuccessAndPop() {
        let alert = UIAlertController(
            title: "Success",
            message: "Your review has been added",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.navigationController?.pop(with: .push)
            self?.coordinator?.backToReviewersVC()
        })
        
        present(alert, animated: true)
    }
    
    private func showErrorAlert() {
        showAlert(
            title: "Error",
            message: "Failed to add review. Please try again."
        )
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
}
// MARK: - Binding
//
extension AddReviewViewController {
    private func bindViewModel() {
        viewModel.reviewSubmissionResult
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                switch result {
                case .success:
                    self?.showSuccessAndPop()
                case .failure (let error):
                    print(error.localizedDescription)
                    self?.showErrorAlert()
                }
            }
            .store(in: &cancellables)
    }
}
