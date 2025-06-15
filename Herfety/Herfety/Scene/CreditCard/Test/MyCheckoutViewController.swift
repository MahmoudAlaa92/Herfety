//
//  MyCheckoutViewController.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 15/06/2025.
//

import UIKit
import StripePaymentSheet

class MyCheckoutViewController: UIViewController {
    
    private(set) var embeddedPaymentElement: EmbeddedPaymentElement?
    
    private lazy var checkoutButton: UIButton = {
        let checkoutButton = UIButton(type: .system)
        checkoutButton.backgroundColor = .systemBlue
        checkoutButton.layer.cornerRadius = 5.0
        checkoutButton.clipsToBounds = true
        checkoutButton.setTitle("Checkout", for: .normal)
        checkoutButton.setTitleColor(.white, for: .normal)
        checkoutButton.translatesAutoresizingMaskIntoConstraints = false
        checkoutButton.isEnabled = embeddedPaymentElement?.paymentOption != nil
        checkoutButton.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside)
        return checkoutButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       #if DEBUG
       Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { [weak self] _ in
           Task { @MainActor in
               self?.embeddedPaymentElement?.testHeightChange()
           }
       }
       #endif
        
        Task { @MainActor in
            do {
                // Create a UIScrollView
                let scrollView = UIScrollView()
                scrollView.translatesAutoresizingMaskIntoConstraints = false
                self.view.addSubview(scrollView)
                
                // Create the Mobile Embedded Payment Element
                let embeddedPaymentElement = try await createEmbeddedPaymentElement()
                embeddedPaymentElement.delegate = self
                embeddedPaymentElement.presentingViewController = self
                self.embeddedPaymentElement = embeddedPaymentElement
                
                // Add its view to the scroll view
                scrollView.addSubview(embeddedPaymentElement.view)
                
                // Add your own checkout button to the scroll view
                scrollView.addSubview(checkoutButton)
                
                // Set up layout constraints
                embeddedPaymentElement.view.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                    scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                    scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                    scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                    
                    embeddedPaymentElement.view.topAnchor.constraint(equalTo: scrollView.topAnchor),
                    embeddedPaymentElement.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                    embeddedPaymentElement.view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                    checkoutButton.topAnchor.constraint(equalTo: embeddedPaymentElement.view.bottomAnchor, constant: 4.0),
                    checkoutButton.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 4.0),
                    checkoutButton.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -4.0),
                ])
                
            } catch {
                // handle view not being added to view
            }
        }
    }
    
    func createEmbeddedPaymentElement() async throws -> EmbeddedPaymentElement {
        let intentConfig = PaymentSheet.IntentConfiguration(
            mode: .payment(amount: 1099, currency: "USD")
        ) { [weak self] _, _, intentCreationCallback in
            self?.handleConfirm(intentCreationCallback)
        }

        var configuration = EmbeddedPaymentElement.Configuration()
        configuration.returnURL = "herfety://stripe-redirect" // ✅ Set your actual custom scheme here

        let embeddedPaymentElement = try await EmbeddedPaymentElement.create(
            intentConfiguration: intentConfig,
            configuration: configuration
        )

        embeddedPaymentElement.presentingViewController = self
        embeddedPaymentElement.delegate = self
        return embeddedPaymentElement
    }
}

extension MyCheckoutViewController: EmbeddedPaymentElementDelegate {
    func embeddedPaymentElementDidUpdateHeight(embeddedPaymentElement: StripePaymentSheet.EmbeddedPaymentElement) {
        // Handle layout appropriately
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    
    func embeddedPaymentElementDidUpdatePaymentOption(embeddedPaymentElement: EmbeddedPaymentElement) {
      print("The payment option changed: \(embeddedPaymentElement.paymentOption)")
      checkoutButton.isEnabled = embeddedPaymentElement.paymentOption != nil
    }
}

extension MyCheckoutViewController {
    @objc func didTapConfirmButton() {
        Task { @MainActor in
            guard let embeddedPaymentElement else { return }
            self.view.isUserInteractionEnabled = false // Disable user interaction, show a spinner, and so on before calling confirm
            let result = await embeddedPaymentElement.confirm()
            switch result {
            case .completed: break
                // Payment completed - show a confirmation screen.
                print("Complete")
            case .failed(let error):
                self.view.isUserInteractionEnabled = true
                // Encountered an unrecoverable error. You can display the error to the user, log it, etc.
                print("InComplete")

                print(error.localizedDescription)
            case .canceled:
                print("Canceled")

                self.view.isUserInteractionEnabled = true
                // Customer canceled - you should probably do nothing.
                break
            }
        }
    }
}

extension MyCheckoutViewController {
    func handleConfirm(_ intentCreationCallback: @escaping (Result<String, Error>) -> Void) {
        let paymentIntentRemote = PaymentIntentRemote(network: AlamofireNetwork()) // or inject it

        let amount = 9000*100

        paymentIntentRemote.createPaymentIntent(amount: amount) { result in
            switch result {
            case .success(let checkoutIntentResponse):
                if let clientSecret = checkoutIntentResponse.clientSecret {
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
