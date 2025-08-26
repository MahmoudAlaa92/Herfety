import Combine
import StripePaymentSheet
import UIKit

class MyCheckoutViewController: UIViewController {
    // MARK: - Properties
    private let viewModel: CheckoutViewModel
    private let scrollView = UIScrollView()
    private let contentStackView = UIStackView()
    private var checkoutButton: HerfetyButton!
    private var subscriptions = Set<AnyCancellable>()
    private lazy var navigationBarBehavior = HerfetyNavigationController(
        navigationItem: navigationItem,
        navigationController: navigationController
    )
    weak var coordinator: CheckoutTransionDelegate?
    weak var alertPresenter: AlertPresenter?
    // MARK: - Init
    init(viewModel: CheckoutViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        loadPaymentElement()
        setUpNavigationBar()
    }
}
// MARK: - Stripe Embedded Delegate
//
extension MyCheckoutViewController: EmbeddedPaymentElementDelegate {
    func embeddedPaymentElementDidUpdateHeight(
        embeddedPaymentElement: EmbeddedPaymentElement
    ) {
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
}
// MARK: - Configuration
//
extension MyCheckoutViewController {
    /// Set up Navigation Bar
    private func setUpNavigationBar() {
        navigationBarBehavior.configure(
            title: L10n.Payment.method,
            titleColor: .primaryBlue,
            onPlus: {
                /// plus button not appear in this VC
            },
            showRighBtn: false,
            showBackButton: true,
        ) { [weak self] in
            self?.coordinator?.backToInfoVC()
        }
    }
    /// UI Setup
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = L10n.Payment.title
        
        // Configure checkout button
        checkoutButton = HerfetyButton()
        checkoutButton.title = L10n.Payment.checkout
        checkoutButton.addTarget(
            self,
            action: #selector(didTapConfirmButton),
            for: .touchUpInside
        )
        
        // Setup scroll view and stack
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.axis = .vertical
        contentStackView.spacing = 16
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentStackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentStackView.topAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.topAnchor,
                constant: 20
            ),
            contentStackView.bottomAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.bottomAnchor,
                constant: -20
            ),
            contentStackView.leadingAnchor.constraint(
                equalTo: scrollView.frameLayoutGuide.leadingAnchor,
                constant: 20
            ),
            contentStackView.trailingAnchor.constraint(
                equalTo: scrollView.frameLayoutGuide.trailingAnchor,
                constant: -20
            ),
        ])
    }
}
// MARK: - Private Handler
//
extension MyCheckoutViewController {
    /// Payment Element
    private func loadPaymentElement() {
        Task { @MainActor in
            do {
                let embeddedPaymentElement =
                try await viewModel.createEmbeddedPaymentElement()
                self.addEmbeddedElementToStack(embeddedPaymentElement)
            } catch {
                let alertItem = AlertModel(
                    message: L10n.Payment.failedWithError(error.localizedDescription),
                    buttonTitle: L10n.General.ok,
                    image: .error,
                    status: .error
                )
                alertPresenter?.showAlert(alertItem)
            }
        }
    }
    private func addEmbeddedElementToStack(_ element: EmbeddedPaymentElement) {
        element.delegate = self
        element.presentingViewController = self
        
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(element.view)
        
        element.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            element.view.topAnchor.constraint(equalTo: container.topAnchor),
            element.view.bottomAnchor.constraint(
                equalTo: container.bottomAnchor
            ),
            element.view.leadingAnchor.constraint(
                equalTo: container.leadingAnchor
            ),
            element.view.trailingAnchor.constraint(
                equalTo: container.trailingAnchor
            ),
            element.view.heightAnchor.constraint(
                greaterThanOrEqualToConstant: 300
            ),
        ])
        
        contentStackView.addArrangedSubview(container)
        contentStackView.addArrangedSubview(checkoutButton)
    }

}
// MARK: - Actions
//
extension MyCheckoutViewController {
    @objc private func didTapConfirmButton() {
        Task { @MainActor in
            let result = await viewModel.confirmPayment()
            self.viewModel.handlePaymentResult(result)
        }
    }
}
// MARK: - Binding
//
extension MyCheckoutViewController {
    private func setupBindings() {
     
        viewModel
            .$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                if isLoading {
                    self?.checkoutButton.showLoader(userInteraction: true)
                }else {
                    self?.checkoutButton.hideLoader()
                }
            }
            .store(in: &subscriptions)
        
        viewModel
            .$alertItem
            .receive(on: DispatchQueue.main)
            .sink { [weak self] alertItem in
                guard let alertItem = alertItem else { return }
                self?.alertPresenter?.showAlert(alertItem)
            }
            .store(in: &subscriptions)
    }
}
