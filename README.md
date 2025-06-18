# 🧵 Handmade Marketplace App - iOS

Welcome to the official documentation for the Handmade Marketplace App – an iOS e-commerce solution built with love for small artisans and handmade vendors. This app was designed to provide a seamless shopping and selling experience, integrating secure payments, modern architecture, and elegant user experience.

---

## 🚀 Project Overview

Handmade Marketplace is a fully functional mobile app that allows users to:

* Explore handmade products from multiple vendors.
* Sign up and log in using social platforms (Facebook, Google, Apple).
* Purchase products securely using Stripe.
* Leave reviews and ratings on purchased products.
* Browse user-friendly interfaces built with UIKit.

---

## 🏗️ Architecture - MVVM

We implemented the **Model-View-ViewModel (MVVM)** design pattern to ensure:

* Clean separation of concerns.
* Easier testability and maintainability.
* Reactive UI updates via Combine.

### Structure:

* **Model**: Represents the app’s data and business logic (e.g., `Product`, `User`, `Review`).
* **View**: UIKit-based views that display data (e.g., `ProductViewController`).
* **ViewModel**: Handles logic and communicates between View and Model.

---

## 🧠 SOLID Principles in Practice

We followed the SOLID principles to keep our codebase scalable and readable:

* **S**: *Single Responsibility* - Each class (e.g., `CheckoutViewModel`) has a distinct job.
* **O**: *Open/Closed* - The networking layer is open for new requests but closed for modification.
* **L**: *Liskov Substitution* - Common protocols are used for polymorphism.
* **I**: *Interface Segregation* - Protocols are small and focused (e.g., `NetworkRequestPerforming`).
* **D**: *Dependency Inversion* - Dependencies are injected (e.g., network clients).

---

## 🎨 UI Design with UIKit

Using UIKit allowed us to build:

* Responsive layouts using Auto Layout.
* Reusable custom components like `ProductCell`, `VendorCollectionView`.
* A smooth, animated checkout flow.

UIKit also provided greater control over presentation and transitions, crucial for creating an emotionally engaging user experience.

---

## 🌐 Networking with Alamofire

We used **Alamofire** to manage all HTTP networking:

* Easy to send authenticated requests.
* Upload and download product images.
* Fetch product listings, vendor data, reviews.

### Example:

```swift
Alamofire.request("/products", method: .get).responseDecodable(of: [Product].self) { response in
   // handle response
}
```

---

## 💳 Payment Integration with Stripe

Stripe’s **EmbeddedPaymentElement** API is used for a secure and customizable checkout:

* Supports multiple vendors.
* Apple Pay ready.
* Secure client secret flow via backend.

### Highlights:

* Users can save payment methods.
* Seamless checkout experience.
* Stripe payments integrated using MVVM.

---

## 🔐 Authentication with Firebase

We use **Firebase Authentication** to simplify sign-in:

* Google Sign-In
* Facebook Login
* Apple Sign-In

Firebase handles token validation, user identity, and security. The sign-in status syncs with Firestore user data.

---

## 🔥 Backend and Firebase Services

The backend includes:

* A server (e.g., Node.js or Laravel) that handles Stripe server-side logic.
* **Firebase Firestore** to store:

  * User profiles
  * Product listings
  * Orders and payments
  * Reviews and ratings

Firebase is used for:

* Real-time data sync.
* Scalable product and review storage.
* Secure access rules per user role.

---

## 🛍️ Product Browsing & Reviews

Users can:

* Browse curated product categories.
* See detailed product views with images, prices, and highlights.
* Add reviews with star ratings and comments.
* View other customers’ feedback.

All reviews are stored in Firestore and linked by `productId`.

---

## 📦 Multi-Vendor Marketplace Support

Each vendor can:

* Upload products.
* View orders.
* Track earnings.

Customers can see vendor profiles and filter products by vendor.

---

## 📱 UX Focused Features

To create an emotionally engaging experience:

* We use subtle animations.
* Feedback for user actions (spinners, alerts).
* Empty states with illustrations.
* For a preview of the app's design, visit the Figma Design Link:
https://www.figma.com/design/jhw6bgjqjuRgZ2jcL0tGv8/Handmade?node-id=0-1&p=f&t=ZRGdXRbsKOym4wcX-0

We focused on **simplicity**, **delight**, and **trust**.

---

## 📚 Conclusion

This project blends solid architecture (MVVM), modern UI with UIKit, and powerful integrations like Stripe and Firebase to deliver a feature-rich, scalable handmade marketplace app.

✨ We believe small makers deserve big tech. ✨

<img width="410" height="800" alt="Screenshot 2025-06-16 at 6 34 41 PM" src="https://github.com/user-attachments/assets/706af593-1210-45ff-9411-080c9e575987" />
<img width="410" height="800" alt="Screenshot 2025-06-16 at 6 35 03 PM" src="https://github.com/user-attachments/assets/a3a9292c-858a-474d-87db-781156568513" />


<img width="410" height="800" alt="Screenshot 2025-06-16 at 6 33 15 PM" src="https://github.com/user-attachments/assets/6e638551-8438-4651-a847-70eec16358f8" />
<img width="410" height="800" alt="Screenshot 2025-06-16 at 6 36 57 PM" src="https://github.com/user-attachments/assets/1f6c3df7-88d0-4b6a-8b03-a8f97fd7afc5" />

<img width="410" height="800" alt="Screenshot 2025-06-16 at 6 37 15 PM" src="https://github.com/user-attachments/assets/fe57e570-308f-46e5-8c0d-0b678e84ec41" />
<img width="410" height="800" alt="Screenshot 2025-06-16 at 6 39 24 PM" src="https://github.com/user-attachments/assets/be4bbee4-f084-42a2-845d-d02613fd04d4" />

<img width="410" height="800" alt="Screenshot 2025-06-16 at 6 42 08 PM" src="https://github.com/user-attachments/assets/a9479e8d-3bc3-4748-9013-80638907af95" />
<img width="410" height="800" alt="Screenshot 2025-06-16 at 6 42 58 PM" src="https://github.com/user-attachments/assets/a7040048-4fc1-4f8a-bf24-f79594e09d4d" />

<img width="410" height="800" alt="Screenshot 2025-06-16 at 6 44 30 PM" src="https://github.com/user-attachments/assets/07e5acea-2c9f-4702-9d7c-ab1bce821a4f" />
<img width="410" height="800" alt="Screenshot 2025-06-16 at 6 44 45 PM" src="https://github.com/user-attachments/assets/a8ea54b7-6ddd-4a89-9eb7-6fa11d1b9ec5" />


<img width="410" height="800" alt="Screenshot 2025-06-16 at 6 43 22 PM" src="https://github.com/user-attachments/assets/f2ac4ca6-05ea-403d-bcc0-93dee5e81289" />
<img width="410" height="800" alt="Screenshot 2025-06-16 at 6 44 11 PM" src="https://github.com/user-attachments/assets/27eb83bc-c835-465b-b556-dcfde1e25df0" />

<img width="410" height="800" alt="Screenshot 2025-06-16 at 6 45 53 PM" src="https://github.com/user-attachments/assets/2fb888f8-35c6-4049-9950-c6f76ec7b173" />
<img width="410" height="800" alt="Screenshot 2025-06-16 at 6 47 08 PM" src="https://github.com/user-attachments/assets/98800200-4034-47fe-97ca-ae0f2939e840" />

<img width="410" height="800" alt="Screenshot 2025-06-16 at 6 47 34 PM" src="https://github.com/user-attachments/assets/0a32877f-7807-4c24-914e-218353c471ac" />
<img width="410" height="800" alt="Screenshot 2025-06-16 at 6 47 48 PM" src="https://github.com/user-attachments/assets/7ab1f6f9-06a4-476a-ac0b-2c7e4aa8b0fc" />

<img width="410" height="800" alt="Screenshot 2025-06-16 at 6 48 21 PM" src="https://github.com/user-attachments/assets/ad0d7759-4a92-4f7c-87a7-6aa13c6b8feb" />
<img width="410" height="800" alt="Screenshot 2025-06-16 at 6 49 18 PM" src="https://github.com/user-attachments/assets/9170da9d-992d-4b7e-9945-87a6b0977b5b" />
