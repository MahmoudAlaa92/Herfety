# 🧵 Handmade Marketplace App - iOS

An iOS e-commerce solution built with love for small artisans and handmade vendors. This app was designed to provide a seamless shopping and selling experience, integrating secure payments, modern architecture, and elegant user experience.

---

## 🚀 Project Overview

Handmade Marketplace is a fully functional mobile app that allows users to:

* Explore handmade products from multiple vendors.
* Sign up and log in using social platforms (Facebook, Google, Apple).
* Purchase products securely using Stripe.
* Leave reviews and ratings on purchased products.
* Browse user-friendly interfaces built with UIKit.

---

## 🏗️ Architecture - MVVM + Design Patterns + SOLID Principles

We implemented the **Model-View-ViewModel (MVVM)** design pattern to ensure:

* Clean separation of concerns.
* Easier testability and maintainability.
* Reactive UI updates via Combine.

Additional design patterns used:

* **Factory** – For object creation (products, users, reviews).
* **Coordinator** – For handling navigation flow.
* **Singleton** – For shared managers.
---

## 📦 Packages & Frameworks Used

We leveraged powerful Swift libraries and Apple frameworks to deliver a production-ready experience:

- **Alamofire** – Networking layer for REST APIs.
- **Firebase** – Authentication, Firestore, and hosting backend services.
- **Stripe iOS SDK** – Secure payments with Apple Pay support.
- **Cosmos** – Star rating control for reviews.
- **Kingfisher** – Downloading & caching images.
- **Lottie** – Animated vector illustrations for engaging UI.
- **Loading Buttons** – Custom styled loading buttons.
- **SkeletonView** – Placeholder skeletons for loading states.
- **ViewAnimator** – One-line view animations for smooth UX.
- **SwiftyJSON** – Easy JSON parsing.
- **SDWebImage** – Image caching & loading.
- **Realm** – Local database for offline-first experience.
- **SwiftGen** – Code generation for assets & strings.
- **SwiftLint** – Linting to enforce Swift style guidelines.
- **Combine** – Reactive programming for UI binding.
- **Async/Await** – Modern concurrency and background task handling.
- **Core ML** – For intelligent recommendations and classifiers (future features).

---

## 💳 Payment Integration with Stripe

Stripe’s **EmbeddedPaymentElement** API is used for a secure and customizable checkout:

* Supports multiple vendors.
* Apple Pay ready.
* Secure client secret flow via backend.

### Highlights:

* Seamless checkout experience.

---

## 🎨 UI Design with UIKit

Using UIKit allowed us to build:

* Responsive layouts with Auto Layout.
* Reusable custom components like `CardViewCell`.
* A smooth, animated checkout flow.
* Localization support for multiple languages.

---

## 🔐 Authentication with Firebase

We use **Firebase Authentication** to simplify sign-in:

* Google Sign-In
* Facebook Login
* Apple Sign-In

Firebase handles token validation, user identity, and security. The sign-in status syncs with Firestore user data.

---

## 🌐 Networking with Alamofire

We used **Alamofire** to manage all HTTP networking:

* Easy to send authenticated requests.
* Upload and download product images.
* Fetch product listings, vendor data, reviews.

---

## 🛍️ Product Browsing & Reviews

Users can:

* Browse curated product categories.
* See detailed product views with images, prices, and highlights.
* Add reviews with star ratings and comments.
* View other customers’ feedback.

All reviews are stored in Firestore and linked by `productId`.

---

## 📱 UX Focused Features

* For a preview of the app's design, visit the Figma Design Link:
https://www.figma.com/design/jhw6bgjqjuRgZ2jcL0tGv8/Handmade?node-id=0-1&p=f&t=ZRGdXRbsKOym4wcX-0

We focused on **simplicity**, **delight**, and **trust**.

---

## 📚 Conclusion

This project blends solid architecture (MVVM), modern UI with UIKit, and powerful integrations like Stripe and Firebase to deliver a feature-rich, scalable handmade marketplace app.

✨ We believe small makers deserve big tech. ✨

<img width="3457" height="2528" alt="HerfetyCover" src="https://github.com/user-attachments/assets/c97a51b3-46f0-49ae-9915-e5dd3f9e624f" />


<img width="410" height="800" alt="Screenshot 2025-06-16 at 6 34 41 PM" src="https://github.com/user-attachments/assets/706af593-1210-45ff-9411-080c9e575987" />
<img width="410" height="800" alt="Screenshot 2025-06-16 at 6 35 03 PM" src="https://github.com/user-attachments/assets/a3a9292c-858a-474d-87db-781156568513" />

<img width="410" height="800" alt="Screenshot 2025-08-30 at 12 41 55 AM" src="https://github.com/user-attachments/assets/918c6bee-1df4-40dd-9455-168f754ae3d7" />
<img width="410" height="800" alt="Screenshot 2025-06-16 at 6 36 57 PM" src="https://github.com/user-attachments/assets/1f6c3df7-88d0-4b6a-8b03-a8f97fd7afc5" />
<img width="410" height="800" alt="Screenshot 2025-06-16 at 6 48 21 PM" src="https://github.com/user-attachments/assets/ad0d7759-4a92-4f7c-87a7-6aa13c6b8feb" />

<img width="410" height="800" alt="Screenshot 2025-06-16 at 6 39 24 PM" src="https://github.com/user-attachments/assets/be4bbee4-f084-42a2-845d-d02613fd04d4" />
<img width="410" height="800" alt="Screenshot 2025-09-07 at 7 20 54 PM" src="https://github.com/user-attachments/assets/08a1b485-ebd1-4dc3-9e04-7411c9e6878e" />

<img width="410" height="800" alt="Screenshot 2025-06-16 at 6 42 58 PM" src="https://github.com/user-attachments/assets/a7040048-4fc1-4f8a-bf24-f79594e09d4d" />

<img width="410" height="800" alt="Screenshot 2025-06-16 at 6 44 30 PM" src="https://github.com/user-attachments/assets/07e5acea-2c9f-4702-9d7c-ab1bce821a4f" />
<img width="410" height="800" alt="Screenshot 2025-06-16 at 6 44 45 PM" src="https://github.com/user-attachments/assets/a8ea54b7-6ddd-4a89-9eb7-6fa11d1b9ec5" />


<img width="410" height="800" alt="Screenshot 2025-06-16 at 6 43 22 PM" src="https://github.com/user-attachments/assets/f2ac4ca6-05ea-403d-bcc0-93dee5e81289" />
<img width="410" height="800" alt="Screenshot 2025-06-16 at 6 44 11 PM" src="https://github.com/user-attachments/assets/27eb83bc-c835-465b-b556-dcfde1e25df0" />

<img width="410" height="800" alt="Screenshot 2025-06-16 at 6 45 53 PM" src="https://github.com/user-attachments/assets/2fb888f8-35c6-4049-9950-c6f76ec7b173" />
<img width="410" height="800" alt="Screenshot 2025-08-30 at 12 40 26 AM" src="https://github.com/user-attachments/assets/4f0f1e3c-c937-4121-89d4-ac81f5ca2fec" />



<img width="410" height="800" alt="Screenshot 2025-06-16 at 6 47 34 PM" src="https://github.com/user-attachments/assets/0a32877f-7807-4c24-914e-218353c471ac" />
<img width="410" height="800" alt="Screenshot 2025-06-16 at 6 47 48 PM" src="https://github.com/user-attachments/assets/7ab1f6f9-06a4-476a-ac0b-2c7e4aa8b0fc" />

<img width="410" height="800" alt="Screenshot 2025-08-30 at 12 38 30 AM" src="https://github.com/user-attachments/assets/9c8b2eb1-0478-49f1-a757-64c68ea5adee" />
<img width="410" height="800" alt="Screenshot 2025-09-07 at 7 35 43 PM" src="https://github.com/user-attachments/assets/9b17be9c-438d-4cf1-a487-ed8b946cd5ff" />


