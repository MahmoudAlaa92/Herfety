import UIKit
import StripePaymentSheet

class MyCheckoutViewController: UIViewController {

    private(set) var embeddedPaymentElement: EmbeddedPaymentElement?

    private let scrollView = UIScrollView()
    private let contentStackView = UIStackView()

    private lazy var checkoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = Colors.primaryBlue
        button.layer.cornerRadius = 10
        button.setTitle("Checkout", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.isEnabled = false
        button.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Payment"

        setupScrollViewAndStack()
        
        Task { @MainActor in
            do {
                let embeddedPaymentElement = try await createEmbeddedPaymentElement()
                self.embeddedPaymentElement = embeddedPaymentElement
                addEmbeddedElementToStack(embeddedPaymentElement)
            } catch {
                print("Failed to create embedded payment element: \(error)")
            }
        }

#if DEBUG
        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { [weak self] _ in
            Task { @MainActor in
                self?.embeddedPaymentElement?.testHeightChange()
            }
        }
#endif
    }

    private func setupScrollViewAndStack() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.axis = .vertical
        contentStackView.spacing = 16
        contentStackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(scrollView)
        scrollView.addSubview(contentStackView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            contentStackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 20),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -20),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 20),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -20),
        ])
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
            element.view.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            element.view.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            element.view.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            element.view.heightAnchor.constraint(greaterThanOrEqualToConstant: 300)
        ])

        contentStackView.addArrangedSubview(container)
        contentStackView.addArrangedSubview(checkoutButton)
    }

    @objc private func didTapConfirmButton() {
        guard let embeddedPaymentElement else { return }

        view.isUserInteractionEnabled = false
        Task { @MainActor in
            let result = await embeddedPaymentElement.confirm()
            view.isUserInteractionEnabled = true

            switch result {
            case .completed:
                print("✅ Payment Complete")
            case .failed(let error):
                print("❌ Payment Failed: \(error.localizedDescription)")
            case .canceled:
                print("⚠️ Payment Canceled")
            }
        }
    }

    private func createEmbeddedPaymentElement() async throws -> EmbeddedPaymentElement {
        let intentConfig = PaymentSheet.IntentConfiguration(
            mode: .payment(amount: 1099, currency: "USD")
        ) { [weak self] _, _, intentCreationCallback in
            self?.handleConfirm(intentCreationCallback)
        }

        var configuration = EmbeddedPaymentElement.Configuration()
        configuration.returnURL = "herfety://stripe-redirect"

        return try await EmbeddedPaymentElement.create(
            intentConfiguration: intentConfig,
            configuration: configuration
        )
    }

    private func handleConfirm(_ intentCreationCallback: @escaping (Result<String, Error>) -> Void) {
        let paymentIntentRemote = PaymentIntentRemote(network: AlamofireNetwork())
        let amount = Int(ceil(Double(CustomeTabBarViewModel.shared.totalPriceOfOrders) * 100.0))
        print("CustomeTabBarViewModel.shared.totalPriceOfOrders\(CustomeTabBarViewModel.shared.totalPriceOfOrders)")

        paymentIntentRemote.createPaymentIntent(amount: amount) { result in
            switch result {
            case .success(let response):
                if let clientSecret = response.clientSecret {
                    intentCreationCallback(.success(clientSecret))
                } else {
                    let error = NSError(domain: "PaymentError", code: 0, userInfo: [
                        NSLocalizedDescriptionKey: "Client secret missing from response"
                    ])
                    intentCreationCallback(.failure(error))
                }
            case .failure(let error):
                intentCreationCallback(.failure(error))
            }
        }
    }
}

// MARK: - Stripe Embedded Delegate
extension MyCheckoutViewController: EmbeddedPaymentElementDelegate {
    func embeddedPaymentElementDidUpdateHeight(embeddedPaymentElement: StripePaymentSheet.EmbeddedPaymentElement) {
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }

    func embeddedPaymentElementDidUpdatePaymentOption(embeddedPaymentElement: EmbeddedPaymentElement) {
        checkoutButton.isEnabled = embeddedPaymentElement.paymentOption != nil
    }
}
